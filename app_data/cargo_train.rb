class CargoTrain < Train
  def initialize(number, manufacturer)
    super

    @type = "cargo"
  end
end