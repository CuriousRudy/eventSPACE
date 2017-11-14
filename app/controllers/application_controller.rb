class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?



  def authorize_user
    unless logged_in?
      flash[:notice] = 'You are not authorized to view this page, log in first.'
      redirect_to root_path
    end
  end

  def logged_in?
    !!session[:user_id]
  end

end
