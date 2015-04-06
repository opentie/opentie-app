class API::V1::ProjectController < Grape::API
  
  
  resource :projects do
    desc 'GET /api/v1/projects/:id'
    params do
      requires :id, type: Integer
    end
    get ':id' do
      Project.find(id: params[:id].to_i)
    end      
  end
  
end
