class SessionsController < ApplicationController

  def new
  end

  def create
    reset_session
    user = User.find_by_email(params[:session][:email])
    if user && user.validate_password(params[:session][:password])
      session[:user_id] = user.id
    else
      return redirect_to new_session_path, notice: "Username / Password incorrect"
    end
  end

  def destroy
    reset_session
  end


end
