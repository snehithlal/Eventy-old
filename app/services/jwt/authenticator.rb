# frozen_string_literal: true

module Jwt
  class Authenticator
    class << self
      def call(headers)
        token = authenticate_header(headers)
        raise Errors::Jwt::MissingToken unless token.present?

        decoded_token = Decoder.decode!(token)
        user = authenticate_user_from_token(decoded_token)
        raise Errors::Unauthorized unless user.present?

        user
      end

      private

      def authenticate_header(headers)
        headers['Authorization']&.split('Bearer ')&.last
      end

      def authenticate_user_from_token(decoded_token)
        raise Errors::Jwt::InvalidToken unless decoded_token[:jti].present? || decoded_token[:user_id].present?

        User.find(decoded_token.fetch(:user_id))
      end
    end
  end
end
