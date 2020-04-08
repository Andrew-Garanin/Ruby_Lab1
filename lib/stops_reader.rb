# frozen_string_literal: true

require 'csv'
require_relative 'stops'
require_relative 'stop'

# Add stop on array from csv file
class StopsReader
  def read_stops(filename)
    stops = Stops.new
    CSV.foreach(filename, headers: true) do |row|
      stops.add_stop(Stop.new(Integer(row['TRAINID']), Integer(row['NUMBER']),
                              Integer(row['STATION_CODE']), row['ARRIVAL_TIME'],
                              Integer(row['STOP_DURATION']), Integer(row['DISTANCE'])))
    end
    stops
    # pp stops
  end
end
