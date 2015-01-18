# -*- encoding: utf-8 -*-
module API
  class API < Grape::API
    version 'v1', using: :path, vendor: 'api'
    format :json

    rescue_from :all do |e|
      Rack::Response.new([ "InternalServerError" ], 500, { "Content-type" => "text/error" }).finish
    end

    helpers do
      def session
        env[Rack::Session::Abstract::ENV_SESSION_KEY]
      end
    end
    
    # Register
    resource :login do
      desc "GET /api/v1/login"
      get do
        # to Shibboleth
        status 200
      end
      
      desc "GET /api/v1/login/call_back"
      get :call_back do
        status 200
      end
    end
    
    resource :dash_board do
      desc "GET /api/v1/dash_board"
      get do
        # authenticate!
        {
          status: 200,
          user_res: ["hoge", "fuga", "piyo"]
        }
      end
    end

    
    # connect Project
    resource :projects do
      desc "GET /api/v1/projects"
      get do
        # authenticate!
        projects = Project.all.each.map{ |project| project }
        {
          status: 200,
          project: projects
        }
      end

      desc "GET /api/v1/projects/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        # authenticate!
        {
          status: 200,
          project: Project.find(params[:id].to_s)
        }
      end

      desc "POST /api/v1/projects"
      params do
        requires :name, type: String
        # etc...
      end
      post do
        status 200
      end
    end

    # connect Bureau
    resource :bureaus do
      desc "GET /api/v1/bureaus"
      get do
        # authenticate!
        bureaus = Bureau.all.each.map { |bureau| bureau }
        {
          status: 200,
          bureau: bureaus
        }
      end

      desc "GET /api/v1/bureaus/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        # authenticate!
        {
          status: 200,
          group: Bureau.find(params[:id].to_s)
        }
      end

      desc "POST /api/v1/bureaus"
      post do
        status 200
      end
    end

    
    # connect Acount
    resource :accounts do
      desc "GET /api/v1/accounts"
      get do
        # authenticate!
        accounts = Account.all.each.map{ |account| account}
        {
          status: 200,
          account: accounts 
        }
      end

      desc "GET /api/v1/accounts/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        # authenticate!
        {
          status: 200,
          account: Account.find(params[:id].to_s)
        }
      end
    end


    # connect Persona
    resource :personas do
      desc "GET /api/v1/personas"
      get do
        # authenticate!
        personas = Persona.all.each.map{ |persona| persona }
        {
          status: 200,
          persona: personas 
        }
      end

      desc "GET /api/v1/personas/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        # authenticate!
        {
          status: 200,
          persona: Persona.find(params[:id].to_s)
        }
      end
    end
  end
end
