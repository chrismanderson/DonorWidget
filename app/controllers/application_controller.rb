class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def login_required
    return redirect_to login_path unless current_user
  end
end
