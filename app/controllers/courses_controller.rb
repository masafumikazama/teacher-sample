class CoursesController < ApplicationController
  
  def create
    
    @course = Course.new(
      course_content: params[:course_content],
      course_level: params[:course_level],
      course_day: params[:course_day],
      course_timing: params[:course_timing],
      
    )
   if @course.save!
      flash[:success] = '授業を作成しました。'
      redirect_to course_url
   else
      flash[:danger] = "授業を作成できませんでした。"
      redirect_to course_url
   end
  
  end
  
  def destroy
    
     course = Course.find(params[:id])
     course.destroy
     flash[:success] = "削除しました。"
    
    redirect_to course_url
    
  end
  
  def edit_course
  
  end
  
end
