# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # rubocop:disable Metrics/MethodLength
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        variable_name = "@#{name}".to_sym
        variable_history_name = "@#{name}_history".to_sym

        define_method("#{name}_history".to_sym) { instance_variable_get(variable_history_name) }
        define_method(name) { instance_variable_get(variable_name) }

        variable_history ||= []

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(variable_history_name, variable_history.push(value))
          instance_variable_set(variable_name, value)
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  module InstanceMethods
  end
end
