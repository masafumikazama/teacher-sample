class AttendancesController < ApplicationController
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def todays_test
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if @attendance.test_score.nil?
       score = rand(1..100)
       @attendance.update_attributes(test_score: score)
       flash[:info] = "本日のテストを受講しました"
    end  
    redirect_to @user
  end
  
  def edit_inquiry
    @user = User.find(params[:id])
    @inquiry = @user.attendances.all
    @users = User.all
    @attendance = @user.attendances.all
  end
  
  def new
    @attendance = Attendance.new
  end
  
  def create_inquiry
    
    @attendance = Attendance.new(
      inquiry: params[:inquiry],
      #今回追加する操作
      user_id: @current_user.id
    )
   if @attendance.save!
      flash[:success] = '新規作成に成功しました。'
      redirect_to user_path
   else
      flash[:danger] = "だめです。"
      redirect_to user_path
   end
  end
  
  private
  
    def inquiry_params
      params.require(:attendance).permit(:inquiry)
    end
  
end