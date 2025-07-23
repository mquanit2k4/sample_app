class SessionsController < ApplicationController
  # GET /login
  def new; end

  # POST /login
  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate params.dig(:session, :password)
      log_in user
      flash[:success] = t "sessions.create.login_success"
      redirect_to user
    else
      flash.now[:danger] = t "sessions.new.invalid_email_password_combination"
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
