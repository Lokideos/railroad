# frozen_string_literal: true

require_relative "support/instance_counter"
require_relative "support/validation"

class Route
  include InstanceCounter
  include Validation

  attr_reader :name, :stations

  validate :name, :presence
  validate :first_station, :type, Station
  validate :last_station, :type, Station

  @@routes = []

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [@first_station, @last_station]
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
end
