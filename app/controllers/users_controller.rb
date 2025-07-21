class UsersController < ApplicationController
  before_action :load_user, only: %i(show)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = I18n.t("new_user.create_success")
      redirect_to @user, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(User::USER_PERMIT)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = I18n.t("users.show.not_found")
    redirect_to root_path
  end
end
