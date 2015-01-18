# -*- encoding: utf-8 -*-
module API
  class API < Grape::API
    version 'v1', using: :path, vendor: 'api'
    format :json

    helpers do
      def session
        env[Rack::Session::Abstract::ENV_SESSION_KEY]
      end
    end
    
    # Register
    resource :login do
      desc "GET /api/v1/login"
      get do
        begin
          # to Shibboleth
          status 200
        rescue
          error!('400 BadRequest', 400)
        end
      end
      
      desc "GET /api/v1/login/call_back"
      get :call_back do
        begin 
          # get Shibboleth callback value.
          # create new Account and redirect new project page.
          status 200
        rescue
          error!('400 BadRequest', 400)
        end
      end
    end
    
    resource :dash_board do
      desc "GET /api/v1/dash_board"
      get do
        begin
          # authenticate!
          {
            status: 200,
            user_res: ["hoge", "fuga", "piyo"]
          }
        rescue
          error!('400 BadRequest', 400)
        end
      end
    end

    
    # connect Project
    resource :projects do
      desc "GET /api/v1/projects"
      get do
        begin
          # authenticate!
          projects = Project.all.each.map{ |project| project }
          {
            status: 200,
            project: projects
          }
        rescue
          error!('400 BadRequest', 400)
        end
      end

      desc "GET /api/v1/projects/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        # authenticate!
        begin
          {
            status: 200,
            project: Project.find(params[:id].to_s)
          }
        rescue
          error!('400 BadRequest', 400)
        end
      end

      desc "POST /api/v1/projects"
      params do
        requires :name, type: String
        # etc...
      end
      post do
        begin 
          # authenticate!
          # Project.new
          # if project is exist, seems update project
          status 200
        rescue
          error!('400 BadRequest', 400)
        end
      end
    end


    # connect Bureau
    resource :bureaus do
      desc "GET /api/v1/bureaus"
      get do
        begin
          # authenticate!
          bureaus = Bureau.all.each.map { |bureau| bureau }
          {
            status: 200,
            bureau: bureaus
          }
        rescue
          error!('400 BadRequest', 400)
        end
      end

      desc "GET /api/v1/bureaus/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        begin
          # authenticate!
          {
            status: 200,
            group: Bureau.find(params[:id].to_s)
          }
        rescue
          error!('400 BadRequest', 400)
        end
      end

      desc "POST /api/v1/bureaus"
      post do
        begin
          # authenticate!
          status 200
        rescue
          error!('400 BadRequest', 400)
        end
      end
    end

    
    # connect Acount
    resource :accounts do
      desc "GET /api/v1/accounts"
      get do
        begin
          # authenticate!
          accounts = Account.all.each.map{ |account| account}
          {
            status: 200,
            account: accounts 
          }
        rescue
          error!('400 BadRequest', 400)
        end
      end

      desc "GET /api/v1/accounts/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        begin
          # authenticate!
          {
            status: 200,
            account: Account.find(params[:id].to_s)
          }
        rescue
          error!('404 BadRequest', 400)
        end
      end
    end


    # connect Persona
    resource :personas do
      desc "GET /api/v1/personas"
      get do
        begin 
          # authenticate!
          personas = Persona.all.each.map{ |persona| persona }
          {
            status: 200,
            persona: personas 
          }
        rescue
          error!('400 BadRequest', 400)
        end
      end

      desc "GET /api/v1/personas/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        begin
          # authenticate!
          {
            status: 200,
            persona: Persona.find(params[:id].to_s)
          }
        rescue
          error!('400 BadRequest', 400)
        end
      end
    end
  end
end
