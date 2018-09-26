# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr_name, validation_type, *args)
      attribute_name = attr_name.to_sym
      validation_type_name = validation_type.to_s.to_sym
      option = args[0]

      if validation_type_name == :presence
        define_method(validation_type_name) do
          raise "Object @#{attribute_name} doesn't exist" if instance_variable_get("@#{attribute_name}".to_sym).nil?
        end
      end

      if validation_type_name == :format
        define_method(validation_type_name) do
          raise "Wrong format of @#{attribute_name}" if instance_variable_get("@#{attribute_name}".to_sym) !~ option
        end
      end

      if validation_type_name == :type
        define_method(validation_type_name) do
          raise "Wrong type of @#{attribute_name}" unless instance_variable_get("@#{attribute_name}".to_sym).class.to_s == option.to_s
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      presence if methods.find { |method_name| method_name == :presence }
      format if methods.find { |method_name| method_name == :format }
      type if methods.find { |method_name| method_name == :type }
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
