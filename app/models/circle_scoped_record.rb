# frozen_string_literal: true

class CircleScopedRecord < ApplicationRecord
  self.abstract_class = true

  if Current.circle.present?
    method(:include).call(CircleScoped)
  end
end
