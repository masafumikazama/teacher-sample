class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :basic_information, :update_basic_information, :test_results, :edit_answer, :create_answer]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :basic_information, :update_basic_information, :edit_answer, :create_answer]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info, :basic_information, :update_basic_information, :edit_answer, :create_answer]
  before_action :set_one_month, only: [:show, :basic_information, :test_results]

  def index
    @users = User.paginate(page: params[:page]).where.not(id: 1)
  end

  def show
    
     @courses = Course.all
    
     time = Time.current
     
     @time = time.hour
    
     @sub_course_content = "まだ未定です。"
    
     @mon_course_content1 = "Reading and Writing the Alphabets"
     @mon_course_content2 = "Reading and Comprehensions"
     @mon_course_content3 = "Story and Conversations"
     
     @tue_course_content1 = "Recreations"
     @tue_course_content2 = "Story and Conversations"
     @tue_course_content3 = "Reading and Comprehensions"
     
     @wed_course_content1 = "Reading and Writing the Alphabets"
     @wed_course_content2 = "Recreations"
     @wed_course_content3 = "Story and Conversations"
     
     @thu_course_content1 = "Reading and Comprehensions"
     @thu_course_content2 = "Recreations"
     @thu_course_content3 = "Reading and Writing the Alphabets"
     
     @fri_course_content1 = "Reading and Writing the Alphabets"
     @fri_course_content2 = "Speech and Conversations"
     @fri_course_content3 = "Reading and Comprehensions"
     
     @sat_course_content1 = "Story and Conversations"
     @sat_course_content2 = "Speech and Conversations"
     @sat_course_content3 = "Reading and Writing the Alphabets"
     
     @sun_course_content1 = "Reading and Writing the Alphabets"
     @sun_course_content2 = "Recreations"
     @sun_course_content3 = "Reading and Comprehensions"
     
     @worked_sum = @attendances.where.not(started_at: nil).count
     
     array = []
      test_ave = @attendances.select(:test_score).where.not(test_score: nil)
      test_ave.each do |i|
       array << i.test_score
     end
      @test_ave = array.sum.fdiv(array.length)
       
     # 中級用授業内容
     @sub_course_content = "まだ未定です。"
    
     @mon_course_content10 = "Alphabets and Phonics"
     @mon_course_content20 = "Reading and Comprehensions"
     @mon_course_content30 = "Story Q&A"
     
     @tue_course_content10 = "Recreations"
     @tue_course_content20 = "Story Q&A"
     @tue_course_content30 = "Reading and Comprehensions"
     
     @wed_course_content10 = "Alphabets and Phonics"
     @wed_course_content20 = "Recreations"
     @wed_course_content30 = "Story Q&A"
     
     @thu_course_content10 = "Reading and Comprehensions"
     @thu_course_content20 = "Recreations"
     @thu_course_content30 = "Alphabets and Phonics"
     
     @fri_course_content10 = "Alphabets and Phonics"
     @fri_course_content20 = "Story Q&A"
     @fri_course_content30 = "Reading and Comprehensions"
     
     @sat_course_content10 = "Story Q&A"
     @sat_course_content20 = "Speech and Conversations"
     @sat_course_content30 = "Alphabets and Phonics"
     
     @sun_course_content10 = "Alphabets and Phonics"
     @sun_course_content20 = "Recreations"
     @sun_course_content30 = "Reading and Comprehensions"
     
     # 上級用の授業内容
     @sub_course_content = "まだ未定です。"
    
     @mon_course_content100 = "Literacy"
     @mon_course_content200 = "Reading and Comprehensions"
     @mon_course_content300 = "Grammer"
     
     @tue_course_content100 = "Recreations"
     @tue_course_content200 = "Grammer"
     @tue_course_content300 = "Reading and Comprehensions"
     
     @wed_course_content100 = "Literacy"
     @wed_course_content200 = "Recreations"
     @wed_course_content300 = "Gremmer"
     
     @thu_course_content100 = "Reading and Comprehensions"
     @thu_course_content200 = "Recreations"
     @thu_course_content300 = "Literacy"
     
     @fri_course_content100 = "Literacy"
     @fri_course_content200 = "Speech and Conversations"
     @fri_course_content300 = "Reading and Comprehensions"
     
     @sat_course_content100 = "Grammer"
     @sat_course_content200 = "Speech and Conversations"
     @sat_course_content300 = "Literacy"
     
     @sun_course_content100 = "Literacy"
     @sun_course_content200 = "Recreations"
     @sun_course_content300 = "Reading and Comprehensions"
     
     # テストの誉め言葉
     @hows_test1 = "good"
     @hows_test2 = "Graet"
     @hows_test3 = "Amazing！"
     @hows_test4 = "Incredible！！"
     @hows_test5 = "Perfect！！！"
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
  
  def edit_note
    @day = Date.parse(params[:day])
    @youbi = params[:youbi]
    @user = User.find(params[:id])
    @attendance = @user.attendances.find_by(worked_on: @day)
    redirect_to(root_url) unless current_user?(@user)
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    (@first_day..@last_day).each do |day|
      unless @user.attendances.any? {|attendance| attendance.worked_on == day}
        record = @user.attendances.build(worked_on: day)
        record.save
      end
    end
    
    @dates = @user.attendances.where('worked_on >= ? and worked_on <= ?', @first_day, @last_day).order('worked_on')
  end
  
  def update_note
    @user = User.find(params[:id])
    @day = Date.parse(params[:day])
    @attendance = @user.attendances.find_by(worked_on: @day)
    
    
     if @attendance.update_attributes(note_params)
      flash[:success] = "連絡事項を更新しました。"
      redirect_to @user
     end
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
      @levels = User.where('level LIKE ?', "%#{params[:level]}%")
    else
      @levels = User.none
    end
  end
  
  def q_a
    array = []
    users = User.all
    users.each do |user|
      inquiries = user.inquiries.where.not(content: nil)
      inquiries.each do |data|
       array.push(data.user.name)
      end
    end
       puts array.uniq
      @user_name = array.uniq
    
  end
  
  
  def basic_information
    @worked_sum = @attendances.where.not(started_at: nil).count
    @tests = @attendances.where.not(test_score: nil)
    
    array = []
    test_ave = @attendances.select(:test_score).where.not(test_score: nil)
    test_ave.each do |i|
      array << i.test_score
    end
    @test_ave = array.sum.fdiv(array.length)
    
    
    score_graph = []
    users = User.all
    users.each do |user|
      attendances = @user.attendances.where.not(test_score: nil)
    
      attendances.each do |test_day|
       childArray = []
       childArray.push(test_day[:worked_on])
       childArray.push(test_day[:test_score])
       score_graph.push(childArray)
      end
    end
     puts score_graph
    @score_graph = score_graph
    
  end
  
  def update_basic_information
  
  end
  
  def inquiriy_create
    @inquiry = Inquiry.new(inquiry_params)
    
    @inquiry.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
  end
  
  def edit_answer
    array = []
    users = User.all
    users.each do |user|
      inquiries = user.inquiries.where.not(content: nil)
      inquiries.each do |data|
       array.push(data.user.name)
      end
    end
       puts array
      @user_name = array
      
      @user_name.each do |username|
        user = User.find_by(name: username)
        @inquiries = user.inquiries.where.not(content: nil)
      end
        
    
    
  end
  
  def create_answer
    @inquiry = Inquiry.new(
      answer: params[:answer],
      #今回追加する操作
      user_id: @current_user.id
      
    )
   if @inquiry.save!
      flash[:success] = '回答を送信しました。'
      redirect_to user_path
   else
      flash[:danger] = "回答を送信できませんでした。"
      redirect_to user_path
   end
  end
  
  def course
    
    @courses = Course.all
    
  end
  
  def edit_course
    
    @courses = Course.all
  
  end
  
  def edit_question
    
    @user = User.find(params[:id])
    @inquiry = @user.inquiries.find_by(params[:id])
    @users = User.all
    @answers = @user.inquiries.all
    
  end
  
  def destroy_question
    inquiry = Inquiry.find(params[:id])
     inquiry.destroy
     flash[:success] = "削除しました。"
    
    redirect_back(fallback_location: user_path)
    
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
    
    def note_params
      params.require(:attendance).permit(:note)
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