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
      requires :payload, type: Hash
      requires :name, type: String
    end
    post '/' do
      project = Project.create(
        name: params[:name],
        payload: params[:payload]
      )
      {
        project: project.attributes
      }
    end

    desc 'POST /api/v1/projects/validate'
    params do
    end
    post '/validate' do
      {}
    end

    desc 'GET /api/v1/projects/new'
    params do
    end
    get '/new' do
      global_setting = GlobalSetting.get(:project_schema)
      {
        project_schema: global_setting
      }
    end
    
    desc 'get /api/v1/projects/:id/edit'
    params do
      requires :id, type: String, desc: 'project_id'
    end
    get '/:id/edit' do
      project = Project.find_by(id: params[:id])
      raise ActiveRecord::RecordNotFound if project.nil?
      global_setting = GlobalSetting.get(:project_schema)
      {
        project: project.attributes,
        project_schema: global_setting
      }
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
      requires :id, type: String, desc: 'project_id'
      requires :payload, type: Hash, desc: 'new project'
    end
    put '/:id' do
      project = Project.find_by(id: params[:id])
      raise ActiveRecord::RecordNotFound if project.nil?
      project.update(payload: params[:payload])
      {
        project: project.reload
      }
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
              add_response({request_schema: @request_schema})
            end
            
            desc 'POST /api/v1/projects/:id/request_schemata/:id/request'
            params do
              requires :payload, type: Hash, desc: 'payloads'
            end
            post '/' do
              delegate = Delegate.find_by(
                project_id: params[:project_id],
                account_id: current_user.id
              )
              request = Request.create(
                delegate_id: delegate.id,
                request_schema_id: params[:request_schema_id],
                payload: params[:payload]
              )
              {
                request: request
              }
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
              {
              }
            end

            desc 'GET /api/v1/projects/:id/request_schemata/:id/request/edit'
            params do
            end
            get '/edit' do
              request = Request.without_soft_destroyed.joins(:delegate)
                .where("delegates.project_id = ?", params[:project_id])
                .where(request_schema_id: params[:request_schema_id])
                .first
              raise ActiveRecord::RecordNotFound if request.nil?
              {
                request: request
              }
            end

            desc 'GET /api/v1/projects/:id/request_schemata/:id/request'
            params do
            end
            get '/' do
              request = Request.without_soft_destroyed.joins(:delegate)
                .where("delegates.project_id = ?", params[:project_id])
                .where(request_schema_id: params[:request_schema_id])
                .first
              raise ActiveRecord::RecordNotFound if request.nil?
              {
                request: request
              }
            end

            desc 'PUT /api/v1/projects/:id/request_schemata/:id/request'
            params do
              requires :payload, type: Hash, desc: "update pyaload"
              requires :status, type: Integer, desc: "update status"
            end
            put '/' do
              request = Request.without_soft_destroyed.joins(:delegate)
                .where("delegates.project_id = ?", params[:project_id])
                .where(request_schema_id: params[:request_schema_id])
                .first
              raise ActiveRecord::RecordNotFound if request.nil?
              request.update(
                payload: params[:payload],
                status: params[:status]
              )
              {
                request: request.reload
              }
            end

            desc 'DELETE /api/v1/projects/:id/request_schemata/:id/request'
            params do
            end
            delete '/' do
              request = Request.without_soft_destroyed.joins(:delegate)
                .where("delegates.project_id = ?", params[:project_id])
                .where(request_schema_id: params[:request_schema_id])
                .first
              raise ActiveRecord::RecordNotFound if request.nil?
              request.soft_destroy!
              {
                request: request
              }
            end
            
          end
        end
      end
    end
    
  end
end
