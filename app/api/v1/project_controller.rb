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

      def accessible_project?(project)
        current_user.projects.include? project
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
    end
    post '/' do
      begin
        project_schema = GlobalSetting.get('project_schema')
        schema = Formalizr::FormSchema.new(project_schema.value)
        payload = schema.normalize(params[:payload])

        project = Project.create(
          name: payload['name'],
          payload: payload
        )
        Delegate.create(
          account_id: current_user.id,
          project_id: project.id
        )
        {
          project: project.attributes
        }
      rescue Formalizr::InvalidInput => err
        {
          validities: err.validities,
          project: { payload: params[:payload] },
          project_schema: project_schema,
        }
      end
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
      project_schema = GlobalSetting.get(:project_schema)
      {
        project_schema: project_schema
      }
    end

    desc 'get /api/v1/projects/:id/edit'
    params do
      requires :id, type: String, desc: 'project_id'
    end
    get '/:id/edit' do
      project = current_user.projects.find_by(id: params[:id])
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
      project = current_user.projects.find_by(id: params[:id])
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
      project = current_user.projects.find_by(id: params[:id])
      raise ActiveRecord::RecordNotFound if project.nil?
      project.update(payload: params[:payload])
      {
        project: project.reload
      }
    end

    route_param :project_id do
      resource :invitations do
        before do
          @project = current_user.projects.find_by(id: params[:project_id])
          raise ActiveRecord::RecordNotFound if @project.nil?
        end

        after_validation do
          add_response({project: @project})
        end

        desc 'GET /api/v1/projects/:id/invitations/new'
        params do
        end
        get '/new' do
          {
          }
        end

        desc 'POST /api/v1/projects/:id/invitations/'
        params do
          requires :email, type: String, desc: "invited email address"
        end
        post '/' do
          Invitation.create(
            project_id: @project.id,
            invited_email: params[:email]
          )
          AccountMailer.invitation(params[:email], current_user).deliver
          {}
        end

        desc 'DELETE /api/v1/projects/:id/invitations/:id/'
        params do
        end
        delete '/:id' do
          invitation = @project.invitations.find_by(id: params[:id])
          invitation.destroy
          {}
        end
      end

      resource :request_schemata do
        before do
          @project = current_user.projects.find_by(id: params[:project_id])
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

            desc 'POST /api/v1/projects/:id/request_schemata/:id/request/validate'
            params do
            end
            post '/validate' do
              {}
            end

            desc 'GET /api/v1/projects/:id/request_schemata/:id/request/edit'
            params do
            end
            get '/edit' do
              request = Request.without_soft_destroyed.joins(:delegate)
                .where("delegates.project_id = ?", @project.id)
                .where(request_schema_id: @request_schema.id)
                .first
              {
                request: request
              }
            end

            desc 'GET /api/v1/projects/:id/request_schemata/:id/request'
            params do
            end
            get '/' do
              request = Request.without_soft_destroyed.joins(:delegate)
                .where("delegates.project_id = ?", @project.id)
                .where(request_schema_id: @request_schema.id)
                .first
              {
                request: request
              }
            end

            desc 'PUT /api/v1/projects/:id/request_schemata/:id/request'
            params do
              requires :payload, type: Hash, desc: "update payload"
              requires :status, type: Integer, desc: "update status"
            end
            put '/' do
              request = Request.without_soft_destroyed.joins(:delegate)
                .where("delegates.project_id = ?", @project.id)
                .where(request_schema_id: @request_schema.id)
                .first

              if request.nil?
                delegate = current_user.delegates.find_by(
                  project_id: @project.id
                )
                begin
                  request_schema = @request_schema.payload
                  schema = Formalizr::FormSchema.new(request_schema['payload'])
                  payload = schema.normalize(params[:payload])

                  delegate.requests << request =  Request.create(
                    request_schema_id: @request_schema.id,
                    payload: payload,
                    status: params[:status],
                  )
                rescue Formalizr::InvalidInput => err
                  next {
                    validities: err.validities,
                    project_schema: request_schema
                  }
                end
              else
                request.update(
                  payload: params[:payload],
                  status: params[:status]
                )
              end

              {
                request: request.reload
              }
            end
          end
        end
      end
    end
  end
end
