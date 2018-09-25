# frozen_string_literal: true

module Validable
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def validate_new!
      validate!
      validate_duplicate!
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
