# -*- encoding: utf-8 -*-
module API
  class API < Grape::API
    version 'v1', using: :path, vendor: 'api'
    format :json

    # Base format
    resource :page do
      # args
      params do
        requires :hoge, type: String
        requires :fuga, type: Integer
      end

      desc "GET /v1/page"
      get do
        status 200
      end

      desc "GET /v1/page/user"
      get :user do
        status 200
      end

      desc "POST /v1/page"
      post do
        error!('401 Unauthorized', 401)
      end
    end
  end
end
