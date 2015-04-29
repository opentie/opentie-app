class API::V1::DashboardController < Grape::API
  resource :dashboard do
    helpers do
      def fulltime_params
        projects = current_user.projects
        divisions = current_user.divisions
        {
          my_projects: projects,
          my_divisions: divisions
        }
      end
    end

    before do
      error!('401 Unauthorized', 401) unless authenticated?
    end

    after_validation do
      add_response(fulltime_params)
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
