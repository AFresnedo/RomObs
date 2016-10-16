class SessionsController < ApplicationController
  def new
  end

  def create
    # find user according to posted email
    @user = User.find_by(email: params[:session][:email].downcase)
    # if user exists and password matches
    if @user && @user.authenticate(params[:session][:password])
      # check activation status
      if @user.activated?
        log_in @user
        # based on user request, either save or delete session cookies
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_to @user
      # instruct on activation status
      else
        message = "Account not activated."
        message += " Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    # user doesn't exist or password doesn't match
    else
      # flash.now for render
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? # important precondition
    redirect_to root_url
  end
end
