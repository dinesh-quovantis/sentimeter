class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  
  helper_method :current_user
  before_action :show_param

  def show_param
  	p "--------------------------------------------------------------------------------------"
  	p "#{params.inspect}"
  	p "---------------------------------------------------------------------------------------"
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_to_twitter_log
  	redirect_to "/auth/twitter" if current_user.blank?
  end	
  
end


