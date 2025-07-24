module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    return @current_user if defined?(@current_user)

    if (user_id = session[:user_id])
      @current_user = find_user_by_session(user_id)
    elsif (user_id = cookies.signed[:user_id])
      @current_user = find_user_by_cookie(user_id)
    end
  end

  def current_user? user
    user && user == current_user
  end

  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:remember_token)
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    forget current_user
    reset_session
    @current_user = nil
  end

  def remember_cookies user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def remember_session user
    user.remember
    session[:remember_token] = user.remember_token
  end

  private

  def find_user_by_session user_id
    user = User.find_by(id: user_id)
    return unless user&.authenticated?(session[:remember_token])

    user
  end

  def find_user_by_cookie user_id
    user = User.find_by(id: user_id)
    return unless user&.authenticated?(cookies[:remember_token])

    log_in user
    user
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
