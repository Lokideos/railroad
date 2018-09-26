# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr_name, validation_type, *_args)
      attribute_name = attr_name.to_sym

      validation_type_name = validation_type.to_s.to_sym
      if validation_type_name == :presence
        define_method(validation_type_name) do
          raise "Object @#{attribute_name} doesn't exist" if instance_variable_get("@#{attribute_name}".to_sym).nil?
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      presence if methods.find { |method_name| method_name == :presence }
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
