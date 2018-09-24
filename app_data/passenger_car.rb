class PassengerCar < Car
  attr_accessor :seats
  attr_reader :max_seats

  def initialize(number, manufacturer, seats)
    super(number, manufacturer)

    @max_seats = seats.to_i
    @seats = 0
  end

  def take_seat
    self.seats += 1 if seats < max_seats
  end

  def free_seats
    max_seats.to_i - seats.to_i
  end
end