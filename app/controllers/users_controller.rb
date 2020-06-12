class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :basic_information, :update_basic_information, :test_results]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :basic_information, :update_basic_information]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info, :basic_information, :update_basic_information]
  before_action :set_one_month, only: [:show, :basic_information, :test_results]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    
     @sub_course_content = "まだ未定です。"
    
     @mon_course_content1 = "初級：月曜日：１０時からの授業です。"
     @mon_course_content2 = "初級：月曜日：１５時からの授業です。"
     @mon_course_content3 = "初級：月曜日：１６時からの授業です。"
     
     @tue_course_content1 = "初級：火曜日：１０時からの授業です。"
     @tue_course_content2 = "初級：火曜日：１５時からの授業です。"
     @tue_course_content3 = "初級：火曜日：１６時からの授業です。"
     
     @wed_course_content1 = "初級：水曜日：１０時からの授業です。"
     @wed_course_content2 = "初級：水曜日：１５時からの授業です。"
     @wed_course_content3 = "初級：水曜日：１６時からの授業です。"
     
     @thu_course_content1 = "初級：木曜日：１０時からの授業です。"
     @thu_course_content2 = "初級：木曜日：１５時からの授業です。"
     @thu_course_content3 = "初級：木曜日：１６時からの授業です。"
     
     @fri_course_content1 = "初級：金曜日：１０時からの授業です。"
     @fri_course_content2 = "初級：金曜日：１５時からの授業です。"
     @fri_course_content3 = "初級：金曜日：１６時からの授業です。"
     
     @sat_course_content1 = "初級：土曜日：１０時からの授業です。"
     @sat_course_content2 = "初級：土曜日：１５時からの授業です。"
     @sat_course_content3 = "初級：土曜日：１６時からの授業です。"
     
     @sun_course_content1 = "初級：日曜日：１０時からの授業です。"
     @sun_course_content2 = "初級：日曜日：１５時からの授業です。"
     @sun_course_content3 = "初級：日曜日：１６時からの授業です。"
     
     
     
     @worked_sum = @attendances.where.not(started_at: nil).count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
    
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def line_chat
    
  end
  
  def test_results
    
  end
  
  def question
    @user = User.find(params[:id])
    @inquiries = @user.inquiries.paginate(page: params[:page])
  end
  
  def search
   
  end
  
  def search_students
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
    
    if params[:level].present?
      @levels = User.where('name LIKE ?', "%#{params[:level]}%")
    else
      @levels = User.none
    end
  end
  
  def q_a
    
  end
  
  def basic_information
    @worked_sum = @attendances.where.not(started_at: nil).count
    array = []
    test_ave = @attendances.select(:test_score).where.not(test_score: nil)
    test_ave.each do |i|
      array << i.test_score
    end

    @test_ave = array.sum.fdiv(array.length)
    
  end
  
  def update_basic_information
  
  end
  
  def inquiriy_create
    @inquiry = Inquiry.new(inquiry_params)
    
    @inquiry.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :level, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:level)
    end
    
    def inquiry_params
       params.require(:inquiry).permit(:content)
    end

    # beforeフィルター

    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end