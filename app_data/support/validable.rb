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
    rescue
      false
    end
  end
end