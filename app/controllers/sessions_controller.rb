class SessionsController < ApplicationController
  REMEMBER_ME = "1".freeze

  # GET /login
  def new; end

  # POST /login
  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate params.dig(:session, :password)
      handle_succeed_login user
    else
      handle_failed_login
    end
  end

  # DELETE /logout
  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  private

  def handle_succeed_login user
    reset_session
    log_in user
    if params.dig(:session,
                  :remember_me) == REMEMBER_ME
      remember_cookies(user)
    else
      remember_session(user)
    end
    flash[:success] = t ".login_success"
    redirect_to user, status: :see_other
  end

  def handle_failed_login
    flash.now[:danger] = t ".invalid_email_password_combination"
    render :new, status: :unprocessable_entity
  end
end
