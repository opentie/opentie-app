class API::V1::ProjectController < Grape::API
  
  resource :projects do
    helpers do
      def fulltime_params
        projects = current_user.projects
        divisions = current_user.divisions
         request_schemata = RequestSchema.all
        {
          my_projects: projects,
          my_divisions: divisions,
          my_request_schemata: request_schemata
        }
      end
    end

    before do
      error!('401 Unauthorized', 401) unless authenticated?
    end

    after_validation do
      add_response(fulltime_params)
    end

    desc 'POST /api/v1/projects/'
    params do
    end
    post '/' do 
      # create
      {}
    end

    desc 'GET /api/v1/projects/new'
    params do
    end
    get '/new' do
      # new
      {}
    end
    
    desc 'get /api/v1/projects/:id/edit'
    params do
    end
    get '/:id/edit' do
      # edit
      {}
    end
    
    desc 'GET /api/v1/projects/:id'
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
    
    desc 'PUT /api/v1/projects/:id'
    params do
    end
    put '/:id' do
      # update
      {}
    end
    
    route_param :project_id do
      resource :request_schemata do
        before do
          @project = Project.find_by(id: params[:project_id])
          raise ActiveRecord::RecordNotFound if @project.nil?
        end

        after_validation do
          add_response({project: @project})
        end

        desc 'GET /api/v1/projects/:id/request_schemata/'
        params do
        end
        get '/' do
          {
            request_schemata: RequestSchema.all
          }
        end

        desc 'GET /api/v1/projects/:id/request_schemata/:id'
        params do
          requires :id, type: String, desc: 'request_schema_id'
        end
        get '/:id' do
          request_schema = RequestSchema.find_by(id: params[:id])
          raise ActiveRecord::RecordNotFound if request_schema.nil?
          {
            request_schema: request_schema
          }
        end
        route_param :request_schema_id do
          resource :request do
            before do
              @request_schema = RequestSchema.find_by(id: params[:request_schema_id])
              raise ActiveRecord::RecordNotFound if @request_schema.nil?
            end
            
            after_validation do
              add_response({project: @request_schema})
            end
            
            desc 'POST /api/v1/projects/:id/request_schemata/:id/request'
            params do
            end
            post '/' do
              # create
              {}
            end
            
            desc 'POST /api/v1/projects/:id/request_schemata/:id/request/validate'
            params do
            end
            post '/validate' do
              {}
            end
            
            desc 'GET /api/v1/projects/:id/request_schemata/:id/request/new'
            params do
            end
            get '/new' do
              # new
              {}
            end

            desc 'GET /api/v1/projects/:id/request_schemata/:id/request/edit'
            params do
            end
            get '/edit' do
              # edit
              {}
            end

            desc 'GET /api/v1/projects/:id/request_schemata/:id/request'
            params do
            end
            get '/' do
              requests = Request.joins(:delegate)
                .where("delegates.project_id = ?", params[:project_id])
                .where(request_schema_id: params[:request_schema_id])
                .first
              {
                request: requests
              }
            end

            desc 'PUT /api/v1/projects/:id/request_schemata/:id/request'
            params do
            end
            put '/' do
              # update
              {}
            end

            desc 'DELETE /api/v1/projects/:id/request_schemata/:id/request'
            params do
            end
            delete '/' do
              # delete
              {}
            end
            
          end
        end
      end
    end
    
  end
end
