# frozen_string_literal: true

# Array of stops
class Stops
  attr_accessor :stops
  def initialize
    @stops = []
  end

  def add_stop(trains_in_list)
    @stops << trains_in_list
  end
end
