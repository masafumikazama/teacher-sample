class InquiriesController < ApplicationController
  
  
  def question
    @user = User.find(params[:id])
    @inquiry = @user.inquiries.all
    @users = User.all
    @answers = @user.inquiries.all
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
   if @inquiry.save!
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
      @user = User.find(params[:id])
      @inquiry = Inquiry.find_by(params[:user_id])
  end
  
  def update_answer
    @user = User.find(params[:id])
    @inquiry = Inquiry.find_by(params[:user_id])
    
    answer_params.each do |id, item|
       inquiry = Inquiry.find(id)
       inquiry.update_attributes(item)
    
       flash[:success] = "質問に回答しました。"
      
     end
      redirect_to user_path     
    
      
  end
  
  def update_q_answer
    @user = User.find_by(params[:id])
    @inquiry = Inquiry.find(params[:id])
    
      if @inquiry.update_attributes(q_answer_params)
    
       flash[:success] = "質問に回答しました。"
      
      end
      redirect_to user_path
  end

  private

   def inquiry_params
       params.require(:inquiry).permit(:content)
   end
   
   def answer_params
       params.require(:user).permit(:answer)
       params.require(:user).permit(inquiries: [:answer])[:inquiries]
   end
   
   def q_answer_params
       params.require(:inquiry).permit(:answer)
   end
end
