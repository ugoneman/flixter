class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: [:new, :create, :update]
  
  def new
    @section = Section.new
  end

  def create
    #@section = @course.sections.create(section_params)
    @section = current_course.sections.create(section_params)
    redirect_to instructor_course_path(current_course)
  end

  def update
    puts params
    current_section.update_attributes(section_params)
    render plain: 'updated!'
  end

  private

  def require_authorized_for_current_section
    @course = Course.find(current_section[:course_id])
    if @course.user != current_user
      render plain: "Unauthorized", status: :Unauthorized
    end
  end

  
  helper_method :current_course
  def current_course
    if params[:course_id]
      @current_course ||= Course.find(params[:course_id])
    else
      current_section.course
    end
  end

  def section_params
    params.require(:section).permit(:title, :row_order_position)
  end
end

