# frozen_string_literal: true

class CircleSerializer < Blueprinter::Base
  identifier :id

  fields :name, :description

  view :with_head do
    association :head, blueprint: UserSerializer, view: :profile_details
  end

  view :with_members do
    field :members do |circle, _|
      UserSerializer.render_as_json(circle.members, view: :profile_details)
    end
  end

  view :with_head_and_members do
    include_views :with_head, :with_members
  end
end
