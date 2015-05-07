class API::V1::RegisterController < Grape::API
  resource :register do
    desc 'GET /api/v1/register'
    params do
    end
    get '/' do
      redirect_to '/dashboard', with: {} if authenticated?
      {
        account_schema: GlobalSetting.get(:account_schema)
      }
    end

    desc 'POST /api/v1/register/'
    params do
      requires :payload, type: Hash, desc: 'payload'
    end
    post '/' do
      begin
        redirect_to '/dashboard', with: {} if authenticated?
        confirm_token = Devise.friendly_token

        account_schema = GlobalSetting.get('account_schema')
        schema =  Formalizr::FormSchema.new(account_schema.value)
        payload = schema.normalize(params[:payload])

        safe_payload = payload.deep_except('password', 'password_confirmation')

        account = Account.new(
          name: payload['name'],
          email: payload['email'],
          password: payload['password'],
          password_confirmation: payload['password_confirmation'],
          payload: safe_payload,
          confirmation_token: confirm_token
        )
        unless account.valid?
          _, validities = schema.validate(params[:payload])
          invalid_columns = account.errors.to_h.keys
          if invalid_columns.include? :password_confirmation
            validities['password_confirmation']['validities'].push(
              { 'validity'=> false, 'description' => '同じパスワードを入力してください'}
            )
          end
          if invalid_columns.include? :email
            validities['email']['validities'].push(
              { 'validity'=> false, 'description' => 'このメールアドレスはすでに登録されています'}
           )
          end
          raise Formalizr::InvalidInput.new('invalid email or password', validities)
        end

        account.save!

        AccountMailer.registration_confirmation(account).deliver
        authenticate!(account)
        {
          account: account
        }
      rescue Formalizr::InvalidInput => err
        {
          validities: err.validities,
          account: { payload:  params[:payload] },
          account_schema: account_schema
        }
      end
    end

    desc 'GET /api/v1/register/confirm'
    params do
      requires :confirm_token, type: String, desc: 'confirm_token'
    end
    get '/confirm' do
      error!('401 Unauthorized', 401) unless authenticated_with_not_included_confirm?
      error!('403 Forbidden', 403) unless current_user.confirmation_token == params[:confirm_token]
      error!('400 Bad request', 400) unless !current_user.confirmed_email

      invitation = Invitation.find_by(invited_email: current_user.email)
      unless invitation.nil?
        invitation.update(account_id: current_user.id)
        Delegate.create(
          account_id: current_user.id,
          project_id: invitation.project_id,
          priority: 1 # fix me
        )
      end

      current_user.update(confirmed_email: true)

      {
      }
    end
  end
end
