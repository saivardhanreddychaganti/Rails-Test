module API  
  module V1
    class Users < Grape::API
      include API::V1::Defaults
        resource :users do
          desc 'user sign_in'
          params do
            requires :email
            requires :password
          end
          post "/sign_in" do
            user = User.where(email: params[:email]).first
            if user.nil?

                error! 'invalid email', 404
            else
              if user.valid_password?(params[:password])
                {message: 'successfull logged in', token: user.create_token}
              else
                error! 'invalid password', 404
              end

            end
          end

          desc 'user sign_up'
          params do
            requires :email
            requires :password
          end
          post "/sign_up" do
            user = User.where(email: params[:email]).first
            if user.nil?
                role = Role.where(name: 'participant')
                user = User.create(email: params[:email], password: params[:password])
                user.roles << role
                {message: 'successfull created user'}
            else
              error! 'email already exists', 404
            end
          end
        end
    end
  end
end  