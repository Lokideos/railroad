class PassengerCar < Car
  def initialize(number, manufacturer)
    super

    @type = "passenger"
  end
end