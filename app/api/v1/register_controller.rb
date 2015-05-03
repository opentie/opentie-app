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
      account = Account.create(
        name: params[:name],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        payload: params[:payload]
      )
      authenticate!(account)
      {
        account: account
      }
    end
    
  end
end
  
