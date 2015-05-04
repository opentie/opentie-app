class API::V1::RegisterController < Grape::API
  resource :register do
    desc 'GET /api/v1/register/new'
    params do
    end
    get '/new' do
      {
        account_schema: GlobalSetting.get(:account_schema)
      }
    end

    desc 'POST /api/v1/register/validate'
    params do

    end
    get '/validate' do
      {}
    end

    desc 'POST /api/v1/register/'
    params do
      requires :name, type: String, desc: 'name'
      requires :email, type: String, desc: 'email'
      requires :password, type: String, desc: 'password'
      requires :password_confirmation, type: String, desc: 'password_confirmation'
      requires :payload, type: Hash, desc: 'payload'
    end
    post '/' do
      next redirect '/api/v1/dashboard' if authenticated?
      confirm_token = Devise.friendly_token

      account = Account.create(
        name: params[:name],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        payload: params[:payload],
        confirmation_token: confirm_token
      )
      AccountMailer.registration_confirmation(account).deliver
      {
        account: account
      }
    end
    
    desc 'GET /api/v1/register/confirm'
    params do
      requires :confirm_token, type: String, desc: 'confirm_token'
    end
    get '/confirm' do
      error!('401 Unauthorized', 401) unless authenticated?
      error!('400 Bad request', 400) unless current_user.confirmation_token == params[:confirm_token]
      error!('400 Bad request', 400) unless !current_user.confirmed_email
      current_user.update(confirmed_email: true)
      {
      }
    end
  end
end
  
