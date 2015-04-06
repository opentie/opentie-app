# app/api/api.rb
class API < Grape::API
  mount API::V1
end
