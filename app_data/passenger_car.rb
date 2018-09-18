class PassengerCar < Car
  def initialize(number, type)
    super

    @type = "passenger"
  end
end