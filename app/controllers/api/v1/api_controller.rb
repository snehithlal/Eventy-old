# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      before_action :authenticate

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from Errors::AuthenticateError, with: :handle_unauthenticated
      rescue_from Errors::Unauthorized, with: :handle_unauthorized
      # rescue_from Exception, with: :handle_exception

      private
        attr_reader :current_user

        def authenticate
          @current_user = Jwt::Authenticator.call(request.headers)
        end

        def record_not_found(error)
          render json: { error: error.message }, status: :not_found
        end

        def parameter_missing(error)
          render json: { error: error.message }, status: :unprocessable_entity
        end

        def handle_unauthenticated
          render json: { error: 'Incorrect username or password' }, status: :unauthorized
        end

        def handle_unauthorized
          render json: { error: 'Please login to continue' }, status: :unauthorized
        end

        def handle_exception(error)
          render json: { error: error.message }, status: :internal_server_error
        end
    end
  end
end
