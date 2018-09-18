class Car
  attr_reader :number, :type

  @@cars = []

  def initialize(number, type)
    @number = number
    type == "passenger" ? @type = type : @type = "cargo"
    @@cars << self
  end

  def self.cars
    @@cars
  end
end