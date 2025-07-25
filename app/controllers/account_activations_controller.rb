class AccountActivationsController < ApplicationController
  before_action :load_user_for_activation, only: [:edit]
  before_action :validate_activation, only: [:edit]

  # GET: /account_activations/:id/edit
  def edit
    @user.activate
    log_in @user
    remember_session @user
    flash[:success] = t(".account_activated")
    redirect_to @user
  end

  private

  def load_user_for_activation
    @user = User.find_by(email: params[:email])
    return if @user

    flash[:danger] = t(".invalid_activation_link")
    redirect_to root_url
  end

  def validate_activation
    return if @user && !@user.activated? && @user.authenticated?(:activation,
                                                                 params[:id])

    flash[:danger] = t(".invalid_activation_link")
    redirect_to root_url
  end
end
