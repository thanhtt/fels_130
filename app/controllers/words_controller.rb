class WordsController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    @courses = Course.all
    @words = if params[:course_id].blank?
      Word.send (params[:option] ||= "all_words"), current_user.id
    else
      @course = Course.find_by id: params[:course_id]
      @course.words.send (params[:option] ||= "all_words"), current_user.id
    end
    @words = @words.paginate page: params[:page]
  end
end
