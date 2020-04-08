# frozen_string_literal: true

# Associete array with stations
class Stations
  attr_accessor :stations
  def initialize
    @stations = {}
  end

  def add_station(key, value)
    @stations[key] = value
  end
end
