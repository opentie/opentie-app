class API::V1::DashboardController < Grape::API
  resource :dashboard do
    before do
      error!('401 Unauthorized', 401) unless authenticated?
    end

    after_validation do
      add_response(current_user.organizations)
    end

    desc "GET /api/v1/dashboard"
    params do
    end
    get do
      {
      }
    end
  end
end
