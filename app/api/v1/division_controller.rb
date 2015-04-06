class API::V1::DivisionController < Grape::API
  
  resource :divisions do
    desc 'GET /api/v1/divisions/:id'
    params do
      requires :id, type: Integer, desc: 'division_id'
    end
    get '/:id' do
      Division.find(id: params[:id],.to_i)
    end

    route_params :division_id do
      resource :projects do
        desc 'GET /api/v1/divisions/:id/projects/'
        params do
        end
        get '/' do

        end

        desc 'GET /api/v1/divisions/:id/projects/:id/'
        params do
          requires :id, type: Integer, desc: 'projest_id'
        end
        get '/:id' do

        end

        route_params :project_id do
          resource :requests do
            desc 'GET /api/v1/divisions/:id/projects/:id/requests/'
            params do
            end
            get '/' do
            
            end

            desc 'GET /api/v1/divisions/:id/projects/:id/requests/:id/'
            params do
              requires :id, type: Integer, desc: 'request_id'
            end
            get '/:id' do

            end
          end
        end
      end

      resource :request_schemata do
        desc 'GET /api/v1/divisions/:id/request_schemata/'
        params do
        end
        get '/' do
          
        end

        desc 'GET /api/v1/divisoins/:id/request_schemata/:id/'
        params do
          requires :id, type: Integer, desc: 'request_schema_id'
        end
        get '/:id' do
          
        end
        
        route_params :request_schema_id do
          resource :requests do
            desc 'GET /api/v1/divisions/:id/request_schemata/:id/requests/'
            params do
            end
            get '/' do

            end

            desc 'GET /api/v1/divisions/:id/request_schemata/:id/requests/:id/'
            params do
              requires :id, type: Integer, desc: 'request_id'
            end
            get '/:id' do

            end
          end
        end
      end
      resource :project_histories do
        desc 'GET /api/v1/divisions/:id/request_histories/'
        params do
        end
        get '/' do
        
        end
      end
    end
  end
end

