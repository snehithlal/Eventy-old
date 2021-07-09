# frozen_string_literal: true

module Jwt
  class Decoder
    def self.decode_access_token!(access_token, verify: true)
      decoded = JWT.decode(access_token, Secret.access_secret, verify, verify_iat: true)[0]
      raise Errors::Jwt::InvalidToken unless decoded.present?

      decoded.symbolize_keys
    end

    def self.decode_access_token(access_token, verify: true)
      decode_access_token!(access_token, verify: verify)
    rescue StandardError
      nil
    end
  end
end
