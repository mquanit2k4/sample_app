class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.includes(:user).paginate(
      page: params[:page] || Setting.default_page,
      per_page: Setting.default_page_items
    )
  end
end
