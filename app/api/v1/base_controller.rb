# coding: utf-8
module V1
  class BaseController < Grape::API
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
        # if you want to use this. you must write "use :attributes".
      end
    end

    # login
    resource :login do
      desc "GET /api/v1/login/"
      get do
        status 200
      end

      desc "POST /api/v1/login/call_back/"
      params do
        
      end
      post :call_back do
        status 200
      end
    end

    # Request
    resource :requests do
      desc "GET /api/v1/requests/"
      params do
        
      end
      get do
        status 200
      end
    end

    # dash_board
    resource :dash_board do
      desc "GET /api/v1/dash_board/"
      get do
        status 200
        {
          user_res: ["hoge", "fuga", "piyo"]
        }
      end
    end

    # connect Project
    resource :projects do
      desc "GET /api/v1/projects"
      get do
        projects =  Project.all.each.map{ |project| project }
        status 200
        {
          project: projects
        }
      end

      desc "GET /api/v1/projects/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        status 200
        {
          #project: Project.find(params[:id].to_s)
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

    
    # connect Acount
    resource :accounts do
      desc "GET /api/v1/accounts"
      get do
        # authenticate!
        accounts = Account.all.each.map{ |account| account}
        status 200
        {
          account: accounts
        }
      end

      desc "GET /api/v1/accounts/:id"
      params do
        requires :id, type: String
      end
      get ':id' do
        status 200
        {
          account: Account.find(params[:id].to_s)
        }
      end
    end
  end
end
