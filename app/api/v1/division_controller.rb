class API::V1::DivisionController < Grape::API

  resource :divisions do
    helpers do
      def fulltime_params
        projects = current_user.projects
        divisions = current_user.divisions
        request_schemata = RequestSchema.all
        project_schema = GlobalSetting.get("project_schema")
        {
          my_projects: projects,
          my_divisions: divisions,
          request_schemata: request_schemata,
          project_schema: project_schema
        }
      end
    end

    before do
      error!('401 Unauthorized', 401) unless authenticated?
    end

    after_validation do
      add_response(fulltime_params)
    end

    desc 'GET /api/v1/divisions/:id'
    params do
      requires :id, type: String, desc: 'division_id'
    end
    get '/:id' do
      division = current_user.divisions.find_by(id: params[:id])
      raise ActiveRecord::RecordNotFound if division.nil?
      {
        division: division.as_json(include: :accounts)
      }
    end

    route_param :division_id do
      resource :projects do
        before do
          @division = current_user.divisions.find_by(id: params[:division_id])
          raise ActiveRecord::RecordNotFound if @division.nil?
        end

        after_validation do
          add_response({division: @division})
        end

        desc 'GET /api/v1/divisions/:id/projects'
        params do
        end
        get '/' do
          {
            projects: Project.all
          }
        end

        desc 'GET /api/v1/divisions/:id/projects/:id'
        params do
          requires :id, type: String, desc: 'project_id'
        end
        get '/:id' do
          project = Project.find_by(id: params[:id])
          raise ActiveRecord::RecordNotFound if project.nil?
          {
            project: project.attributes
          }
        end

        route_param :project_id do
          resource :requests do
            before do
              @project = Project.find_by(id: params[:project_id])
              raise ActiveRecord::RecordNotFound if @project.nil?
            end

            after_validation do
              add_response({project: @project})
            end

            desc 'GET /api/v1/divisions/:id/projects/:id/requests'
            params do
            end
            get '/' do
              requests = Request.without_soft_destroyed
                .joins(:delegate).joins(:request_schema)
                .where("request_schemata.division_id = ?", @division.id)
                .where("request_schema_id = request_schemata.id")
                .where("delegates.project_id = ?", @project.id)
              {
                requests: requests
              }
            end

            desc 'GET /api/v1/divisions/:id/projects/:id/requests/:id'
            params do
              requires :id, type: String, desc: 'request_id'
            end
            get '/:id' do
              request = Request.without_soft_destroyed
                .joins(:delegate).joins(:request_schema)
                .where("request_schemata.division_id = ?", @division.id)
                .where("request_schema_id = request_schemata.id")
                .where("delegates.project_id = ?", @project.id)
                .find_by(id: params[:id])
              raise ActiveRecord::RecordNotFound if request.nil?
              {
                request: request.attributes
              }
            end
          end
        end
      end

      resource :request_schemata do
        before do
          @division = current_user.divisions.find_by(id: params[:division_id])
          raise ActiveRecord::RecordNotFound if @division.nil?
        end

        after_validation do
          add_response({division: @division})
        end

        desc 'GET /api/v1/divisions/:id/request_schemata'
        params do
        end
        get '/' do
          schemata = @division.request_schemata
          {
            request_schemata: schemata
          }
        end

        desc 'GET /api/v1/divisoins/:id/request_schemata/:id'
        params do
          requires :id, type: String, desc: 'request_schema_id'
        end
        get '/:id' do
          schema = @division.request_schemata.find_by(id: params[:id])
          raise ActiveRecord::RecordNotFound if schema.nil?
          {
            request_schema: schema.attributes
          }
        end

        route_param :request_schema_id do
          resource :requests do
            before do
              @request_schema = @division.request_schemata.find_by(id: params[:request_schema_id])
              raise ActiveRecord::RecordNotFound if @request_schema.nil?
            end

            after_validation do
              add_response({request_schema: @request_schema})
            end

            desc 'GET /api/v1/divisions/:id/request_schemata/:id/requests'
            params do
            end
            get '/' do
              requests = @request_schema.requests.without_soft_destroyed
              {
                requests: requests
              }
            end

            desc 'GET /api/v1/divisions/:id/request_schemata/:id/requests/:id'
            params do
              requires :id, type: String, desc: 'request_id'
            end
            get '/:id' do
              request = @request_schema.requests.without_soft_destroyed.find_by(id: params[:id])
              raise ActiveRecord::RecordNotFound if request.nil?
              {
                request: request.attributes
              }
            end
          end
        end
      end
      resource :project_histories do
        before do
          @division = current_user.divisions.find_by(id: params[:division_id])
          raise ActiveRecord::RecordNotFound if @division.nil?
        end

        after_validation do
          add_response({division: @division})
        end

        desc 'GET /api/v1/divisions/:id/project_histories'
        params do
        end
        get '/' do
          histories = ProjectHistory.all.order(:updated_at)
          {
            project_histories: histories
          }
        end
      end
    end
  end
end
