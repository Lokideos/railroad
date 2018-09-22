module Validable
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
    rescue
      false
    end
  end
end