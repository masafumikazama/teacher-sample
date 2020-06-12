class InquiriesController < ApplicationController
  
  
  def question
    @user = User.find(params[:id])
    @inquiry = @user.inquiries.all
    @users = User.all
  end
  
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(
      content: params[:content],
      #今回追加する操作
      user_id: @current_user.id
    )
   if @inquiry.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to user_path
   else
      flash[:danger] = "だめです。"
      redirect_to user_path
   end
     
  end

  def destroy
  end

  private

   def inquiry_params
       params.require(:inquiry).permit(:content)
   end
    
  
end
