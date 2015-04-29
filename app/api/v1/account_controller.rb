class API::V1::AccountController < Grape::API
  resource :me do
    after_validation do
      add_response(current_user.organizations)
    end
  end
end

