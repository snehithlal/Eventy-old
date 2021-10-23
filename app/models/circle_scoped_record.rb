# frozen_string_literal: true

class CircleScopedRecord < ApplicationRecord
  self.abstract_class = true

  if Current.circle && Current.circle.is_a?(Circle)
    method(:include).call(CircleScoped)
  end
end
