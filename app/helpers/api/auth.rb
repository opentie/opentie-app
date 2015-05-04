module API::Auth
  
  def session
    env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end
  
  def authenticated?
    !current_user.nil? && email_confirmed?
  end

  def authenticate!(account)
    session[:account_id] = account.id
    session[:expires_at] = Time.zone.now + 60.minutes
  end

  def revoke!
    session.destroy
  end

  def email_confirmed?
    return false if current_user.nil?
    current_user.confirmed_email
  end

  def current_user
    unless available?
      session.destroy
      return nil
    end
    Account.find_by(id: session[:account_id])
  end

  def available?
    return if session[:expires_at].nil?
    session[:expires_at] > Time.zone.now
  end
end
