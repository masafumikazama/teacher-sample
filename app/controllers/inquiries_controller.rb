class InquiriesController < ApplicationController
  
  
  def question
    @user = User.find(params[:id])
    @inquiry = @user.inquiries.all
    @users = User.all
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
      flash[:success] = '質問を送信しました。'
      redirect_to user_path
   else
      flash[:danger] = "質問を送信できませんでした。"
      redirect_to user_path
   end
     
  end

  def destroy
    
     inquiry = Inquiry.find(params[:id])
     inquiry.destroy
     flash[:success] = "削除しました。"
    
    redirect_to q_a_url
    
  end

  private

   def inquiry_params
       params.require(:inquiry).permit(:content)
   end
    
  
end
