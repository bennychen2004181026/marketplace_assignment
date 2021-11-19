class SessionsController < ApplicationController

  def new

  end

  def create
    if user = login(params[:email], params[:password])
      update_session_uuid user.uuid

      flash[:notice] = "Successfully login"
      redirect_to root_path
    else
      flash[:notice] = "Incorrect email or password"
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    cookies.delete :user_uuid
    flash[:notice] = "Successfully logout!"
    redirect_to root_path
  end

end
