module API::Auth
  def session
    env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end

  def authenticated?
    !current_user.nil?
  end

  def authenticate!(account)
    account.ensure_session_token!
    session[:token] = account.session_token
  end

  def current_user
    return nil if session[:token].blank?
    Account.where(session_token: session[:token]).first
  end
end
