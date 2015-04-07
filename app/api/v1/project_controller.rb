class API::V1::ProjectController < Grape::API
  
  resource :projects do
    before do
      error!('401 Unauthorized', 401) unless authenticated?
    end

    desc 'GET /api/v1/projects/:id/'
    params do
      requires :id, type: String, desc: 'project_id'
    end
    get '/:id' do
      # show
      Project.find(params[:id])
    end

    desc 'GET /api/v1/projects/new'
    params do
    end
    get '/new' do
      # new
    end

    desc 'POST /api/v1/projects/'
    params do
    end
    post '/' do 
      # create
    end

    desc 'PUT /api/v1/projects/:id/edit'
    params do
    end
    put '/:id/edit' do
      # edit
    end

    route_param :project_id do
      resource :request_schemata do
        desc 'GET /api/v1/projects/:id/request_schemata/'
        params do
        end
        get '/' do
          # index
        end

        desc 'GET /api/v1/projects/:id/request_schemata/:id/'
        params do
          requires :id, type: String, desc: 'project_schema_id'
        end
        get '/:id' do
          # show
        end
        
        resource :request do
          desc 'GET /api/v1/projects/:id/request_schemata/:id/request/'
          params do
          end
          get '/' do
            # show
          end

          desc 'GET /api/v1/projects/:id/request_schemata/:id/request/new'
          params do
          end
          get '/new' do
            # new
          end

          desc 'POST /api/v1/projects/:id/request_schemata/:id/request/'
          params do
          end
          post '/' do
            # create
          end

          desc 'GET /api/v1/projects/:id/request_schemata/:id/request/edit'
          params do
          end
          get '/edit' do
            # edit
          end

          desc 'PUT /api/v1/projects/:id/request_schemata/:id/request/'
          params do
          end
          put '/' do
           # update
          end

          desc 'DELETE /api/v1/projects/:id/request_schemata/:id/request/'
          params do
          end
          delete '/' do
            # delete
          end
          
        end
      end
    end
    
  end
end
