class StaticpagesController < ApplicationController
  def home
    @feed_items = Activity.activities(current_user).
      paginate page: params[:page]
  end
end
