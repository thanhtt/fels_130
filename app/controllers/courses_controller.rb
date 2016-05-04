class CoursesController < ApplicationController
   before_action :logged_in_user, only: [:index]

  def index
    @courses = Course.paginate page: params[:page]
  end
end
