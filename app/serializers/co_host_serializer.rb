# frozen_string_literal: true

class CoHostSerializer < Blueprinter::Base
  identifier :id

  association :user, blueprint: UserSerializer
end
