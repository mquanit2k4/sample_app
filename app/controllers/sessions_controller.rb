class SessionsController < ApplicationController
  before_action :load_user_by_email, only: :create
  before_action :validate_user_activation, only: :create

  REMEMBER_ME = "1".freeze

  # GET /login
  def new; end

  # POST /login
  def create
    if @user&.authenticate(params.dig(:session, :password))
      handle_login_success(@user)
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

  def load_user_by_email
    email = params.dig(:session, :email)&.downcase
    @user = User.find_by(email:)
    return if @user

    flash.now[:danger] = t(".user_not_found")
    render :new, status: :unprocessable_entity
  end

  def validate_user_activation
    return if @user.activated?

    flash[:warning] = t(".account_not_activated")
    redirect_to root_url, status: :see_other
  end

  def handle_login_success user
    forwarding_url = session[:forwarding_url]
    reset_session
    if params.dig(:session, :remember_me) == REMEMBER_ME
      remember_cookies(user)
    else
      remember_session(user)
    end
    log_in user
    flash[:success] = t(".login_success")
    redirect_to forwarding_url || user
  end

  def handle_failed_login
    flash.now[:danger] = t ".invalid_email_password_combination"
    render :new, status: :unprocessable_entity
  end
end
