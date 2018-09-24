class CargoCar < Car
  attr_accessor :volume
  attr_reader :max_volume

  def initialize(number, manufacturer, volume)
    super(number, manufacturer)

    @max_volume = volume
    @volume = 0
  end

  def load(volume)
    self.volume += volume if self.volume + volume <= max_volume
  end

  def free_volume
    max_volume - volume
  end
end