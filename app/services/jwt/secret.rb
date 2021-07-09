# frozen_string_literal: true

module Jwt
  class Secret
    def self.access_secret
      Rails.application.credentials.dig(:jwt, :access_token_secret)
    end
  end
end
