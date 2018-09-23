require_relative 'support/instance_counter'
require_relative 'support/validable'

class Route
  include InstanceCounter
  include Validable

  attr_reader :name, :stations

  @@routes = []

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station.name} - #{last_station.name}"
    validate!
    register_instance
    @@routes << self
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) unless first_station?(station) || last_station?(station)
  end

  def self.existing_routes
    @@routes
  end

  private

  def first_station?(station)
    station == @stations[0]
  end

  def last_station?(station)
    station == @stations[-1]
  end

  protected

  def validate!
    raise RuntimeError, "Name cannot be empty." if name == "" || name.nil?
    raise RuntimeError, "First station can't be the last station." if stations.first == stations.last
    raise RuntimeError, "Route already exists." if @@routes.find { |route| name == route.name }
    true
  end
end