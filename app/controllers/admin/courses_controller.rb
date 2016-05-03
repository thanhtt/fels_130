class Admin::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def index
    @courses = Course.paginate page: params[:page]
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "course_success_created" 
      redirect_to admin_courses_path
    else
      flash[:danger] = t "course_error"
      render :new
    end
  end

  private
  def course_params
    params.require(:course).permit :name, :description
  end
end
