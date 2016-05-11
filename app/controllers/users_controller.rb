class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :following, :followers]
  before_action :load_user, only: [:show, :edit, :update]

  def show
    @activities = @user.activities.order(created_at: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      flash[:danger] = t "profile_updated_errors"
      render :edit
    end
  end

  def index
    @users = User.all
  end

  def following
    @title = t "following"
    @user = User.find params[:id]
    @users = @user.following.paginate page: params[:page]
    render :show_follow
  end

  def followers
    @title = t "followers"
    @user = User.find params[:id]
    @users = @user.followers.paginate page: params[:page]
    render :show_follow
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
