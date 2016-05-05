class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def new
    course = Course.find params[:course_id]
    @word = course.words.build
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "success"
      redirect_to [:admin, @word.course]
    else
      flash.now[:danger] = t "_error"
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :content, :course_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
