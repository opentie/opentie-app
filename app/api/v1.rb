class API::V1 < Grape::API
  version 'v1', using: :path

  prefix :api
  content_type :json, 'application/json'

  format :json
  default_format :json

  helpers API::Auth
  helpers API::Redirect

  helpers do
    def add_response(hash)
      @block = @block.merge_hash(hash)
    end
  end

  after do
    Rails.logger.info(options.to_s)
    Rails.logger.info("Request Params: " + @params.to_s)
    Rails.logger.info("Return Sattus: " + status.to_s)
    Rails.logger.info("++++++++++++++++++++++++++++++++++++\n\n\n\n")
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    Rails.logger.error("404 Not Found -> " + e.message)
    Rails.logger.error(e.backtrace.join("\n"))
    Rails.logger.info("++++++++++++++++++++++++++++++++++++\n\n\n\n")

    error_response(message: "Not found", status: 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    Rails.logger.error("400 Bad Request -> " + e.message)
    Rails.logger.error(e.backtrace.join("\n"))
    Rails.logger.info("++++++++++++++++++++++++++++++++++++\n\n\n\n")

    error_response(message: "Bad Request", status: 400)
  end

  rescue_from :all do |e|
    Rails.logger.error("500 Internal Server Error -> " + e.message)
    Rails.logger.error(e.backtrace.join("\n"))
    Rails.logger.info("++++++++++++++++++++++++++++++++++++\n\n\n\n")
    error_response(message: "Internal Server Error", status: 500)
  end

  mount RegisterController
  mount AccountController
  mount ProjectController
  mount DivisionController
  mount CertificationController
  mount DashboardController
end
