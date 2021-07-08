class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  # set default expiry from 24 hours from creation time
  # sign token with application secret
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JwT.encode(payload, SECRET_KEY)
  end

  # get payload from decoded Array
  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new body
  rescue JWT.DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
