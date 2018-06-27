module API  
  module V1
    class Tasks < Grape::API
      include API::V1::Defaults

        resource :tasks do
          before { check_login }


          desc "Return all Tasks"
          params do
            requires :token
          end
          get "/", serializer: :TaskSerializer  do
            Task.all
          end

          desc "Create Tasks"
          params do
            requires :token
            requires :title
          end
          post "/", serializer: :TaskSerializer do
            task = Task.create(title: params[:title])
            {message: 'created successfully'}
          end	
        end
    end
  end
end  