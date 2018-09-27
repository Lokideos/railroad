# frozen_string_literal: true

require_relative "support/instance_counter"
require_relative "support/validation"

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  validate :name, :presence

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
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

  def trains_to_block
    @trains.each { |train| yield(train) }
  end

  def self.all
    @@stations
  end
end
