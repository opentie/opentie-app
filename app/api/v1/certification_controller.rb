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
        # return psuedo success page for missmatched mail addr
        # error!({ message: "email doesn't match" }, 401) if account.nil?
        unless account.nil?
          # TODO: 同一アドレスに対して有効なトークンを複数同時に発行された状態にしない
          token = RecoveryToken.create_new_token(account.id)
          AccountMailer.recovery_token(params[:email], account, token).deliver
        end
        { message: 'sent recovery token URI by mail' }
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
        token = RecoveryToken.find_by(token: params[:token])
        account = token.account
        if token.is_valid?
          account.update(
            password: params[:password],
            password_confirmation: params[:password_confirmation]
          )
          token.update(resetted_password: true)
          if account.save && token.save
            { message: 'new password has been saved successfully' }
          else
            error!({ message: "password doesn't match" }, 401)
          end
        else
          error!({ message: 'token has been expired' }, 401)
        end
      else
        { message: 'already authenticated' }
      end
    end
  end
end
