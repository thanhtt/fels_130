class LessonsController < ApplicationController
  before_action :load_lesson, only: [:show, :update]
  before_action :load_course, only: :create

  def show
  end

  private
  def load_lesson
    @lesson = Lesson.find params[:id]
  end

  def load_course
    @course = Course.find params[:course_id]
  end
end
