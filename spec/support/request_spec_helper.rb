# frozen_string_literal: true

module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def auth_response_without_token
    json['user'].except('auth_token')
  end

  def token_generator(user)
    Jwt::Issuer.call(user)
  end

  def valid_headers(user = FactoryBot.create(:user))
    {
      'Authorization': token_generator(user),
      'Content-Type': 'application/json'
    }
  end
end
