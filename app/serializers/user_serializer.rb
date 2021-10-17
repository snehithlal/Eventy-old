# frozen_string_literal: true

class UserSerializer < Blueprinter::Base
  identifier :id

  fields :user_name

  view :profile_details do
    fields :email, :full_name
  end

  view :with_auth_token do
    field :auth_token do |user, _|
      Jwt::Issuer.call(user)
    end
  end

  view :with_circles do
    field :joined_circles do |user, _|
      CircleSerializer.render_as_json(user.joined_circles, root: :circles, view: :with_head_and_members)
    end
  end
end
