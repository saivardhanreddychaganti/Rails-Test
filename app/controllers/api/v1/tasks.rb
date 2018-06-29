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
          get "/"  do
            token_user
            if can? :index, Task
              Task.all
            else
              error! 'you cannot access this resource' , 404
            end
          end

          desc "Create Tasks"
          params do
            requires :token
            requires :title
          end
          post "/" do
            token_user
            if can? :create, Task
              task = Task.create(title: params[:title])
              {message: 'created successfully'}

            else
              error! 'you cannot access this resource' , 404
            end
          end	


          desc "Create Tasks"
          params do
            requires :token
            requires :id
          end
          delete ":id" do
            token_user
            if can? :destroy, Task
              # binding.pry
              task = Task.where(id: params[:id]).destroy_all
              {message: 'deleted successfully successfully'}
            else
              error! 'you cannot access this resource' , 404
            end
          end 
        end
    end
  end
end  