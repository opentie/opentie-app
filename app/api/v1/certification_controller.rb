class API::V1::CertificationController < Grape::API
  resource :login do
    desc 'POST /api/v1/login'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post do
      unless authenticated?
        account = Account.find_by(email: params[:email])
        error!({ message: "email doesn't match" }, 401) if account.nil?
        error!({ message: "password doesn't match" }, 401) unless account.authenticate(params[:password])
        authenticate!(account)
        {
          message: 'Accept authenticate'
        }
      else
        {
          message: 'Already authenticated'
        }
      end
    end
  end

  resource :logout do
    desc 'POST /api/v1/logout'
    params do
    end
    post do
      revoke!
      {
        message: 'Successful logout'
      }
    end
  end

  resource :recovery_tokens do
    desc 'POST /api/v1/recovery_tokens'
    params do
      requires :email, type: String
    end
    post do
      unless authenticated?
        account = Account.find_by(email: params[:email])
        error!({ message: "email doesn't match" }, 401) if account.nil?
        token = SecureRandom.urlsafe_base64(50)
        RecoveryToken.create(token: token, account_id: account.id)
        AccountMailer.recovery_token(params[:email], token)
      else
        { message: 'already authenticated' }
      end
    end

    desc 'POST /api/v1/recovery_tokens/:token'
    params do
      requires :token, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    post '/:token' do
      unless authenticated?
        token = RecoveryToken.find_by(token: params[:token]).account
        if token.created_at > 1.hour.ago && (! token.resetted_password)
          account.update(
            password: params[:password],
            password_confirmation: params[:password_confirmation]
          )
          account.save!
          token.update(resetted_password: true).save!
        else
          error!({ message: 'token has been expired' }, 401)
        end
      else
        { message: 'already authenticated' }
      end
    end
  end
end
