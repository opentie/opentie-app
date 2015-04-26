class API::V1::DashboardController < Grape::API
  resource :dashboard do
    before do
      error!('401 Unauthorized', 401) unless authenticated?
    end

    desc "GET /api/v1/dashboard"
    params do
    end
    get do 
      {
        divisions: current_user.delegates,
        projects: current_user.projects
      }
    end
  end
end
