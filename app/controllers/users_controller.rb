class UsersController < ApplicationController

  before_filter :find_current_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    uparams = params[:user]
    @user = User.create(email: uparams[:email])
    @user.store_password(uparams[:password])
    if @user.save
      reset_session
      session[:user_id] = @user.id
    else
      flash[:notice] = @user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def destroy
    @user.delete
  end

  def show
  end

  def edit
  end

  def update
    uparams = params[:user]
    @user.update_attributes(email: uparams[:email]) if uparams[:email]
    @user.store_password(uparams[:password]) if uparams[:password]
  end

  def find_current_user
    @user = current_user
    raise @user.inspect
    return redirect_to login_path unless @user
  end
end
