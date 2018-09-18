class Car
  attr_reader :number

  @@cars = []

  def initialize(number)
    @number = number
    @@cars << self
  end

  def self.cars
    @@cars
  end
end