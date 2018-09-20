require_relative 'support/manufacturered'

class Car
  include Manufacturered
  
  attr_reader :number

  @@cars = []

  def initialize(number, manufacturer)
    @number = number
    @manufacturer = manufacturer
    @@cars << self
  end

  def self.cars
    @@cars
  end
end