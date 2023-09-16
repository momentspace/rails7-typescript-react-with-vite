class ApplicationController < ActionController::Base
  include Pundit::Authorization
  protect_from_forgery with: :exception
  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def authenticate
    if current_user.blank?
      session[:user_redirect_url] = request.fullpath if request.get?
      user_not_authenticated
    end
  end

  def user_not_authenticated
    session.delete :user_id
    redirect_to user_sign_in_path
  end

  def user_not_authorized
    flash[:error] = "You are not authorized"
    redirect_to(request.referrer || root_path)
  end
end
