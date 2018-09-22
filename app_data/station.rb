require_relative 'support/instance_counter'
require_relative 'support/validable'

class Station
  include InstanceCounter
  include Validable

  attr_reader :name, :trains

  @@stations = []

  def initialize (name)
    @name = name
    @trains = []
    validate!
    duplicate_validate!
    register_instance
    @@stations.push(self)
  end

  def arrival_of_train(train)
    @trains.push(train)
  end

  def trains_of_type(train_type)
    @trains.select { |train| train.type == train_type }
  end

  def departure_of_train(train)
    @trains.delete(train)
  end

  def self.all
    @@stations
  end

  protected

  def validate!
    raise RuntimeError, "Name for station wasn't set" if name.nil? || name == ""
    true
  end

  def duplicate_validate!
    raise RuntimeError, "Station with this name already exists." if @@stations.find { |station| name == station.name }
    true
  end
end