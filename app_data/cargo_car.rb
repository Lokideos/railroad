class CargoCar < Car
  def initialize(number, manufacturer)
    super

    @type = "cargo"
  end
end