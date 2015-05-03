class API::V1 < Grape::API
  version 'v1', using: :path
  
  prefix :api
  content_type :json, 'application/json'

  format :json
  default_format :json
  
  helpers API::Auth

  helpers do
    def add_response(hash)
      @block = @block.merge_hash(hash)
    end
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    error_response(message: "Not found", status: 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    binding.pry
    error_response(message: "Bad request", status: 400)
  end

  rescue_from :all do |e|
    error_response(message: "Internal server error", status: 500)
  end
  
  mount RegisterController
  mount AccountController
  mount ProjectController
  mount DivisionController
  mount CertificationController
  mount DashboardController
end
