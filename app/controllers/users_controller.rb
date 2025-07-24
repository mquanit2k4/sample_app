class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :load_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  # GET /users/:id
  def show; end

  # GET /users/:id/edit
  def edit; end

  # PATCH /users/:id
  def update
    if @user.update(user_params)
      flash[:success] = t(".update_success")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # GET /users
  def index
    @pagy, @users = pagy User.recent, items: Settings.default_page_items
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy
      flash[:success] = t(".user_deleted")
    else
      flash[:danger] = t(".delete_failed")
    end
    redirect_to users_path
  end

  # GET /signup
  def new
    @user = User.new
  end

  # POST /signup
  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = I18n.t(".create_success")
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

    flash[:danger] = I18n.t(".user_not_found")
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t(".please_login")
    redirect_to login_url
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t(".cannot_edit")
    redirect_to root_url
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t(".not_admin")
    redirect_to root_path
  end
end
