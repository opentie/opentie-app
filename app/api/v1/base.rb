# coding: utf-8
module V1
  class Base < Grape::API
    format :json
    default_format :json

    # */hoge.json
    content_type :json, 'application/json'
    
    prefix :api
    version 'v1', using: :path

    #rescue_from ActiveRecord::RecordNotFound do |e|
    #  rack_response(message:  e.message, status: 404)
    #end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      rack_response e.to_json, 400
    end

    rescue_from :all do |e|
      error_response(message: "Internal server error", status: 500)
    end

    helpers do
      def session
        env[Rack::Session::Abstract::ENV_SESSION_KEY]
      end

      params :attributes do
        # public argment
        # "use :attributes"
      end
    end

    # Register
    resource :login do
      desc "GET /api/v1/login.json"
      get do
        #connecter =  OpenidConnecter.new {}
        #{
        #  status: 200,
        #  url: connecter.get_redirect_url
        #}
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
