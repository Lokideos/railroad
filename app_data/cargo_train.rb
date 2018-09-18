class CargoTrain < Train
  def initialize(number, type)
    super

    @type = "cargo"
  end
end