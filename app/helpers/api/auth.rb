module API::Auth
  def session
    env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end

  def authenticated
    !current_user.nil?
  end

  def authenticate!(account)
    remember_token = Account.ensure_session_token
    session[:token] = remember_token
    account.update_attribute(:remember_token, remember_token)
  end

  def current_user
    return nil if session[:token].blank?
    Account.find_by(remember_token: session[:token])
  end
end
