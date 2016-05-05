class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_word, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "success"
      redirect_to [:admin, @word.course]
    else
      flash.now[:danger] = t "_error"
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "_error"
    end
    redirect_to :back
  end

  private
  def word_params
    params.require(:word).permit :content, :course_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_word
    @word = Word.find params[:id]
  end
end
