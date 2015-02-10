# app/api/api.rb

class API < Grape::API
  mount V1::BaseController
  # mount V2::Base
end
