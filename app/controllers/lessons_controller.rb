class LessonsController < ApplicationController
  before_action :load_course, only: [:show, :create]
  before_action :load_lesson, only: [:show, :update]

  def show
    @words = @lesson.words
  end

  def create
    @lesson = current_user.lessons.new course_id: @course.id
    if @lesson.save
      flash[:success] = t "create_lesson_success"
      redirect_to [@lesson.course, @lesson]
    else
      flash[:success] = t "create_lesson_fail"
      redirect_to courses_path
    end
  end

  def update
    @lesson.update_attributes lesson_params
    redirect_to :back
  end

  private
  def load_course
    @course = Course.find params[:course_id]
  end

  def load_lesson
    @lesson = Lesson.find params[:id]
  end

  def lesson_params
    params.require(:lesson).permit :user_id, :course_id, :finished,
      results_attributes: [:id, :word_id, :answer_id]
  end
end
