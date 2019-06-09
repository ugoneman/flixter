class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course
    
  def show
    #@course ||= current_lesson.section.course
    #current_course
  end

  private

  def require_authorized_for_current_course
    if !current_user.enrolled_in?(current_course)
      #render plain: "Unauthorized", status: :unauthorized
      redirect_to course_path(current_course), alert: 'Please Enroll in Course to view details'
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= current_lesson.section.course
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
