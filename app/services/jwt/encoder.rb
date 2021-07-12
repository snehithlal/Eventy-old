# frozen_string_literal: true

module Jwt
  class Encoder
    class << self
      def call(user)
        issue_access_token(user)
      end

      private

      def issue_access_token(user)
        JWT.encode(
          {
            user_id: user.id,
            jti: SecureRandom.hex,
            iat: token_issued_at.to_i,
            exp: access_token_expiry
          },
          Secret.access_secret
        )
      end

      def access_token_expiry
        (token_issued_at + 7.days).to_i
      end

      def token_issued_at
        Time.current
      end
    end
  end
end
