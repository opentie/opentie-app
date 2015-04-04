# app/api/api.rb

class API < Grape::API
  version 'v1', using: :path
  
  prefix :api
  content_type :json, 'application/json'

  format :json
  default_format :json
  
  helpers API::Auth
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response e.to_json, 404
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response e.to_json, 400
  end

  rescue_from :all do |e|
    error_response(message: "Internal server error", status: 500)
  end

  mount V1::BaseController
  mount V1::Register
end
