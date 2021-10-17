# frozen_string_literal: true

module CircleScoped
  extend ActiveSupport::Concern

  included do
    default_scope { where(circle_id: Current.circle.id) }

    belongs_to :circle
  end
end
