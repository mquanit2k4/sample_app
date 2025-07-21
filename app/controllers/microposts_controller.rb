class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.includes(:user).paginate(
      page: params[:page] || Settings.default_page,
      per_page: Settings.default_page_items
    )
  end
end
