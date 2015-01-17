# -*- encoding: utf-8 -*-
module API
  class API < Grape::API
    version 'v1', using: :path, vendor: 'api'
    format :json
    
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
      
      desc "GET /api/v1/register/callback"
      get :callback do
        begin 
          # get Shibboleth callback value.
          # create new Account and redirect new project page.
          status 200
        rescue
          error!('400 BadRequest', 400)
        end
      end
    end
    resource :dash_board
    desc "GET /api/v1/dash_board"
    params do
      requires :user_data1, type: String
      requires :user_data2, type: String
    end
    get do
      begin
        # authenticate!
        {
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
        Project.all.each.map do |project|
          project.to_json
        end
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
        Project.find(:id).to_json
      rescue
        error!('400 BadRequest', 400)
      end
    end

    desc "POST /api/v1/projects/create"
    params do
      requires :name, type: String
      # etc...
    end
    post :create do
      begin 
        # authenticate!
        # Project.new
        status 200
      rescue
        error!('400 BadRequest', 400)
      end
    end

    desc "POST /api/v1/projects/update"
    params do
      requires :name, type: String
      # etc...
    end
    post :update do
      begin
        # save performer
        # Project resave!
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
        Group.all.each.map do |group|
          group.to_json
        end
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
        Group.find(:id).to_json
      rescue
        error!('400 BadRequest', 400)
      end
    end

    desc "POST /api/v1/groups/create"
    params do
      requires :is_jitsui, type: Boolean
      # other
    end
    post :create do
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
        Account.all.each.map do |account|
          account.to_json
        end
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
        Account.find(:id).to_json
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
        Persona.all.each.map do |persona|
          persona.to_json
        end
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
        Persona.find(:id).to_json
      rescue
        # authenticate!
        error!('400 BadRequest', 400)
      end
    end
  end
end

