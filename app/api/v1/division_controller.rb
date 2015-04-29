class API::V1::DivisionController < Grape::API
  
  resource :divisions do
    before do
      error!('401 Unauthorized', 401) unless authenticated?
    end

    after_validation do
      add_response(current_user.organizations)
    end
    
    desc 'GET /api/v1/divisions/:id'
    params do
      requires :id, type: String, desc: 'division_id'
    end
    get '/:id' do
      division = Division.find_by(id: params[:id])
      raise ActiveRecord::RecordNotFound if division.nil?
      members = division.accounts
      {
        body: division.attributes.merge({members: members})
      }
    end

    route_param :division_id do
      resource :projects do
        desc 'GET /api/v1/divisions/:id/projects'
        params do
        end
        get '/' do
          {
            body: Project.all
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
            body: project.attributes
          }
        end

        route_param :project_id do
          resource :requests do
            desc 'GET /api/v1/divisions/:id/projects/:id/requests'
            params do
            end
            get '/' do
              requests = Request.joins(:delegate)
                .where("delegates.project_id = ?", params[:project_id])
              {
                body: requests
              }
            end

            desc 'GET /api/v1/divisions/:id/projects/:id/requests/:id'
            params do
              requires :id, type: String, desc: 'request_id'
            end
            get '/:id' do
              request = Request.find_by(id: params[:id])
              raise ActiveRecord::RecordNotFound if request.nil?
              {
                body: request.attributes
              }
            end
          end
        end
      end

      resource :request_schemata do
        desc 'GET /api/v1/divisions/:id/request_schemata'
        params do
        end
        get '/' do
          schemata = RequestSchema.where(division_id: params[:divison_id])
          {
            body: schemata
          }
        end

        desc 'GET /api/v1/divisoins/:id/request_schemata/:id'
        params do
          requires :id, type: String, desc: 'request_schema_id'
        end
        get '/:id' do
          schema = RequestSchema.find_by(id: params[:id])
          raise ActiveRecord::RecordNotFound if schema.nil?
          {
            body: schema.attributes
          }
        end
        
        route_param :request_schema_id do
          resource :requests do
            desc 'GET /api/v1/divisions/:id/request_schemata/:id/requests'
            params do
            end
            get '/' do
              requests = Request.where(request_schema_id: params[:request_schema_id])
              {
                body: requests
              }
            end

            desc 'GET /api/v1/divisions/:id/request_schemata/:id/requests/:id'
            params do
              requires :id, type: String, desc: 'request_id'
            end
            get '/:id' do
              request = Request.find_by(id: params[:id])
              raise ActiveRecord::RecordNotFound if request.nil?
              {
                body: request.attributes
              }
            end
          end
        end
      end
      resource :project_histories do
        desc 'GET /api/v1/divisions/:id/project_histories'
        params do
        end
        get '/' do
          histories = ProjectHistory.all.order(:updated_at)
          {
            body: histories
          }
        end
      end
    end
  end
end

