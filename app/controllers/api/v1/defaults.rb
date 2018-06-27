module API  
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, 
             Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, 
               include_missing: false)
          end

          def check_login
            if params[:token].nil?
              error! 'invalid token please login', 404
            else
              if UserToken.where(token: params[:token]).first
                true
              else
                error! 'invalid token please check', 404
              end
            end
          end

          def logger
            Rails.logger
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end
    end
  end
end  