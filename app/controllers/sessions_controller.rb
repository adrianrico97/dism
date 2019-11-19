class SessionsController < ApplicationController

  def new
    render :layout => false
  end

  def create
    user = User.find_by_email(params[:email]) || User.find_by_login(params[:email])
    if user && user.active? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_index_path
    else
      flash.now[:alert] = I18n.t('login.user_password_invalid')
      render "new", :layout => false
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end