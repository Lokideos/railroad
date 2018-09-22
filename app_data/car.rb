require_relative 'support/manufacturered'
require_relative 'support/validable'

class Car
  include Manufacturered
  include Validable
  
  attr_reader :number, :manufacturer

  @@cars = []

  def initialize(number, manufacturer)
    @number = number
    @manufacturer = manufacturer
    validate!
    duplicate_validate!
    @@cars << self
  end

  def self.all
    @@cars
  end

  protected

  def validate!
    raise RuntimeError, "Number cannot be empty." if number == "" || number.nil?
    raise RuntimeError, "Manufacturer cannot be empty." if manufacturer == "" || manufacturer.nil?
    true
  end

  def duplicate_validate!
    raise RuntimeError, "Car with this number already exists." if Car.all.find { |car| number == car.number }
    true
  end

end