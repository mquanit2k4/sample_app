class StaticPagesController < ApplicationController
  # GET /home
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy current_user.feed,
                              limit: Settings.default_page_items
  end

  # GET /help
  def help; end

  # GET /contact
  def contact; end
end
