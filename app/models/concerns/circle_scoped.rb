# frozen_string_literal: true

module CircleScoped
  extend ActiveSupport::Concern

  included do
    default_scope { where(circle_id: Current.circle.id) }

    belongs_to :circle

    before_validation :set_circle

    validates :circle_id, presence: true
  end

  module ClassMethods
    # overriding since default_scope wont work with uniqueness validation
    def validates_uniqueness_of(*attributes)
      options = attr_names.extract_options!.symbolize_keys
      options[:scope] = Array.wrap(options.delete(:scope)) | [:circle_id]
      
      attributes << options
      super
    end

    # overriding since default_scope wont work with uniqueness validation
    def validates(*attributes)
      options = attributes.extract_options!.symbolize_keys
      if options[:uniqueness].present?
        if options[:uniqueness].is_a?(Hash)
          options[:uniqueness][:scope] = Array.wrap(options[:uniqueness].delete(:scope)) | [:circle_id]
        else
          options[:uniqueness] = { scope: :circle_id }
        end
      end
      
      attributes << options
      super
    end

    def inherited(sub_klass)
      Circle.method(:has_many).call(sub_klass.table_name.pluralize.to_sym, dependent: :destroy)

      super
    end
  end

  def set_circle
    self.circle = Current.circle
  end
end
