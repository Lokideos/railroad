# frozen_string_literal: true

class CargoCar < Car
  attr_accessor :volume
  attr_reader :max_volume

  def initialize(number, manufacturer, volume)
    super(number, manufacturer)

    @max_volume = volume.to_f
    @volume = 0
    validate_volume!
  end

  def load(volume)
    self.volume += volume if self.volume + volume <= max_volume
  end

  def free_volume
    max_volume.to_f - volume.to_f
  end

  protected

  def validate_volume!
    raise "Maximum volume can't be less then 0." if @max_volume.negative?

    true
  end
end
