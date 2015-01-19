# app/api/api.rb

class API < Grape::API
  mount V1::Base
  # mount V2::Base
end
