class ApplicationController < ActionController::Base
  helper_method :current_user, :acc

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def acc
    current_user.try(:account)
  end

end