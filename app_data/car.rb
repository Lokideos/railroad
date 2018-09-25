# frozen_string_literal: true

require_relative "support/manufacturered"
require_relative "support/validable"

class Car
  include Manufacturered
  include Validable

  attr_reader :number, :manufacturer

  @@cars = []

  def initialize(number, manufacturer)
    @number = number
    @manufacturer = manufacturer
    validate_new!
    @@cars << self
  end

  def self.all
    @@cars
  end

  protected

  def validate!
    raise "Number cannot be empty." if number == "" || number.nil?
    raise "Manufacturer cannot be empty." if manufacturer == "" || manufacturer.nil?

    true
  end

  def validate_duplicate!
    raise "Car with this number already exists." if Car.all.find { |car| number == car.number }

    true
  end
end
