class PassengerTrain < Train
  def initialize(number, manufacturer)
    super

    @type = "passenger"
  end
end