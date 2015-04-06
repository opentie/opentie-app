class API::V1::ProjectController < Grape::API
  
  resource :projects do
    desc 'GET /api/v1/projects/:id/'
    params do
      requires :id, type: Integer, desc: 'project_id'
    end
    get ':id' do
      Project.find(id: params[:id].to_i)
    end      

    route_params do
      resource :requests do
        desc 'GET /api/v1/projects/'
        params do
        end
        get '/' do
          
        end

        desc 'GET /api/v1/projects/:id/'
        params do
          require :id, type: Integer, desc: 'request_id'
        end
        get ':id' do
          
        end
      end
      
      resource :request_schemata do
        desc 'GET /api/v1/request_schemata/'
        params do
        end
        get '/' do

        end

        desc 'GET /api/v1/request_schemata/:id/'
        params do
          require :id, type: Integer, desc: 'project_schema_id'
        end
        get ':id' do

        end
      end
    end

  end
end
