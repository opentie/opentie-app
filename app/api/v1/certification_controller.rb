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
        error!({ message: "passwords doesn't match" }, 400) unless account.authenticate(params[:password])
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
end
