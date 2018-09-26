# frozen_string_literal: true

module Manufacturered
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    attr_accessor :manufacturer
  end
end
