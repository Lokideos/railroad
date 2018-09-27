# frozen_string_literal: true

require_relative "support/manufacturered"
require_relative "support/validation"

class Car
  include Manufacturered
  include Validation

  attr_reader :number, :manufacturer

  validate :number, :presence
  validate :manufacturer, :presence

  @@cars = []

  def initialize(number, manufacturer)
    @number = number
    @manufacturer = manufacturer
    validate!
    @@cars << self
  end

  def self.all
    @@cars
  end
end
