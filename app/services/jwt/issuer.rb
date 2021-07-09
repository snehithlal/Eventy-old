# frozen_string_literal: true

module Jwt
  class Issuer
    def self.call(user)
      Encoder.call(user)
    end
  end
end
