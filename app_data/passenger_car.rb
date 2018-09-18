class PassengerCar < Car
  def initialize(number)
    super

    @type = "passenger"
  end
end