class LessonsController < ApplicationController
  before_action :load_course, only: [:show, :create]
  before_action :load_lesson, only: [:show, :update]

  def show
    @words = @course.words
  end

  def create
    @lesson = current_user.lessons.new course_id: @course.id
    if @lesson.save
      flash[:success] = t "create_lesson_success"
      redirect_to :back
    else
      flash[:success] = t "create_lesson_fail"
      redirect_to courses_path
    end
  end

  private
  def load_course
    @course = Course.find params[:course_id]
  end

  def load_lesson
    @lesson = Lesson.find params[:id]
  end
end
