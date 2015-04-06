module V1
  class Login < Grape::API
    resource :login do
      
      desc 'POST /api/v1/login'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post do
        account = Account.find_by(email: params[:email])
        error!({ message: "passwords don't match" }, 400) unless account.authenticate(params[:password])
        authenticate!(account)
        status 200
      end

    end
  end
end
