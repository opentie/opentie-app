class API::V1::DivisionController < Grape::API
  
  resource :divisions do
    before do
      error!('401 Unauthorized', 401) unless authenticated?
    end
    
    desc 'GET /api/v1/divisions/:id'
    params do
      requires :id, type: String, desc: 'division_id'
    end
    get '/:id' do
      division = Division.find_by(id: params[:id])
      raise ActiveRecord::RecordNotFound if division.nil?
      division
    end

    route_param :division_id do
      resource :projects do
        desc 'GET /api/v1/divisions/:id/projects'
        params do
        end
        get '/' do
          Project.all
        end

        desc 'GET /api/v1/divisions/:id/projects/:id'
        params do
          requires :id, type: String, desc: 'project_id'
        end
        get '/:id' do
          project = Project.find_by(id: params[:id])
          raise ActiveRecord::RecordNotFound if project.nil?
          project
        end

        route_param :project_id do
          resource :requests do
            desc 'GET /api/v1/divisions/:id/projects/:id/requests'
            params do
            end
            get '/' do
              Request.joins(:delegate)
                .where("delegates.project_id = ?", params[:project_id])
            end

            desc 'GET /api/v1/divisions/:id/projects/:id/requests/:id'
            params do
              requires :id, type: String, desc: 'request_id'
            end
            get '/:id' do
              request = Request.find_by(id: params[:id])
              raise ActiveRecord::RecordNotFound if request.nil?
              request
            end
          end
        end
      end

      resource :request_schemata do
        desc 'GET /api/v1/divisions/:id/request_schemata'
        params do
        end
        get '/' do
          RequestSchema.where(division_id: params[:divison_id])
        end

        desc 'GET /api/v1/divisoins/:id/request_schemata/:id'
        params do
          requires :id, type: String, desc: 'request_schema_id'
        end
        get '/:id' do
          schema = RequestSchema.find_by(id: params[:id])
          raise ActiveRecord::RecordNotFound if schema.nil?
          schema
        end
        
        route_param :request_schema_id do
          resource :requests do
            desc 'GET /api/v1/divisions/:id/request_schemata/:id/requests'
            params do
            end
            get '/' do
              Request.where(request_schema_id: params[:request_schema_id])
            end

            desc 'GET /api/v1/divisions/:id/request_schemata/:id/requests/:id'
            params do
              requires :id, type: String, desc: 'request_id'
            end
            get '/:id' do
              request = Request.find_by(id: params[:id])
              raise ActiveRecord::RecordNotFound if request.nil?
              request
            end
          end
        end
      end
      resource :project_histories do
        desc 'GET /api/v1/divisions/:id/project_histories'
        params do
        end
        get '/' do
          ProjectHistory.all.order(:updated_at)
        end
      end
    end
  end
end

