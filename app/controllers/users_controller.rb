class UsersController < ApplicationController
  before_action :authorize_user, only: [:dashboard]
  helper_method :friend_status


  # def require_login
  #   unless logged_in?
  #     flash[:error] = "You must be logged in to access this section"
  #     redirect_to root_path
  #   end
  # end

  # def index
  # end

  def show
    @user = User.find(params[:id])
    @friendship = Friendship.new
    @friend_status = friend_status(@user)
  end

  def new
    @user = User.new
  end

  def create
    # byebug
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You're logged in!"
      redirect_to user_dashboard_path
    else
      flash[:notice] = "Your sign up information is invalid, please try again."
      render new_user_path
    end
  end

  def dashboard
    @friends = current_user.accepted_friends
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def users_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :birthday, :bio, :profile)
  end

  def friend_status(user)
    if user == current_user
      @friend_status = ""
    elsif user.friend?(current_user) && current_user.friend?(user)
      @friend_status = "Friends"
    elsif current_user.friend?(user)
      @friend_status = "Request Sent"
    elsif user.friend?(current_user)
      @friend_status = "Accept Request"
    else
      @friend_status = "Add Friend"
    end
  end

end
