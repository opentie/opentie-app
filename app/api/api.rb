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
    resource :register do
      desc "GET /api/v1/register"
      get do
        begin
          # to Shibboleth
          status 200
        rescue
          error!('400 BadRequest', 400)
        end
      end
      
      desc "GET /api/v1/register/call_back"
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
          }.to_json
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
          projects = Project.all.each.map do |project|
            project
          end
          {
            status: 200,
            project: projects
          }.to_json
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
          }.to_json
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


    # connect Group
    resource :groups do
      desc "GET /api/v1/groups"
      get do
        begin
          # authenticate!
          groups = Group.all.each.map do |group|
            group.to_json
          end
          {
            status: 200,
            group: groups
          }.to_json
        rescue
          error!('400 BadRequest', 400)
        end
      end

      desc "GET /api/v1/groups/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        begin
          # authenticate!
          {
            status: 200,
            group: Group.find(params[:id].to_s)
          }.to_json
        rescue
          error!('400 BadRequest', 400)
        end
      end

      desc "POST /api/v1/groups"
      params do
        requires :is_jitsui, type: Boolean
        # other
      end
      post do
        begin
          # authenticate!
          # if project is exist, seems update project
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
          accounts = Account.all.each.map do |account|
            account
          end
          {
            status: 200,
            account: accounts 
          }.to_json
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
          }.to_json
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
          personas = Persona.all.each.map do |persona|
            persona
          end
          {
            status: 200,
            persona: personas 
          }.to_json
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
          }.to_json
        rescue
          error!('400 BadRequest', 400)
        end
      end
    end
  end
end
