module SessionsHelper

  def log_in user
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def remember user
    # create a token and store digest in db
    user.remember
    # create user identity cookie for user's browser
    cookies.permanent.signed[:user_id] = user.id
    # create token key in user's browser to match against digest in db
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    # if logged in
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    # if not logged in but browser has login cookies
    elsif (user_id = cookies.signed[:user_id])
      # get user according to browser's cookie information
      user = User.find_by(id: user_id)
      # verify cookie remember token by comparing to digest in db
      if user && user.authenticated?('remember', cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user? user
    user == current_user
  end

  def blog_owner blog
    current_user == User.find_by_id(blog.user_id)
  end

  def forget user
    # delete token digest in db
    user.forget
    # delete browser cookies
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end

end
