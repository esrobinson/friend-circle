module SessionsHelper

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logout!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    unless logged_in?
      flash[:notices] = ["You have to be logged in to do that!"]
      redirect_to new_session_url
    end
  end

end
