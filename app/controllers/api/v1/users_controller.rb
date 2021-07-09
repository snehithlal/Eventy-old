# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate, only: :create

      def create
        user = User.new(user_params)

        if user.save
          render json: UserSerializer.render_as_json(user, root: :user, token: Jwt::Issuer.call(user)), status: :created
        else
          render json: { error: user.errors.full_messages.join(',') }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:user_name, :email, :first_name, :middle_name, :last_name, :password)
      end
    end
  end
end
