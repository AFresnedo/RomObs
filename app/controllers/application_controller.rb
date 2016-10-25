class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to   login_url
      end
    end

    def admin_user
      if logged_in?
        redirect_to(root_url) unless current_user.admin?
      else
        logged_in_user
      end
    end
end
