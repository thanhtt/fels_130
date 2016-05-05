class Admin::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_course, only: [:edit, :update, :destroy]

  def index
    @courses = Course.paginate page: params[:page]
  end

  def edit
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

  def update
    if @course.update_attributes course_params
      flash[:success] = t "course_update"
      redirect_to admin_courses_path
    else
      render :edit
    end
  end

  def destroy 
    if @course.destroy      
      flash[:success] = t "course_deleted"      
    else
      flash[:danger] = t "course_can_not_delete"     
    end
    redirect_to admin_courses_path
  end

  def show
    @course = Course.find params[:id]
  end

  private
  def course_params
    params.require(:course).permit :name, :description
  end

  def load_course
    @course = Course.find params[:id]
  end
end
