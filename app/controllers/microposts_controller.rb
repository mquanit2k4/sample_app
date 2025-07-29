class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user_post, only: :destroy

  # POST /microposts
  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t(".create_success")
      redirect_to root_url
    else
      @pagy, @feed_items = pagy current_user.feed,
                                items: Settings.default_page_items
      render "static_pages/home", status: :unprocessable_entity
    end
  end

  # DELETE /microposts/:id
  def destroy
    if @micropost.destroy
      flash[:success] = t(".deleted_success")
    else
      flash[:danger] = t(".deleted_fail")
    end
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(Micropost::MICROPOST_CREATE_PERMIT)
  end

  def correct_user_post
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t(".micropost_invalid")
    redirect_to request.referer || root_url
  end
end
