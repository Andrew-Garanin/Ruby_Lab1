# frozen_string_literal: true

require 'csv'
require_relative 'stations'
require_relative 'station'

# Add station on array from csv file
class StationsReader
  def read_stations(filename)
    stations = Stations.new
    CSV.foreach(filename, headers: true) do |row|
      stations.add_station(
        Integer(row['CODE']),
        row['TITLE'].strip
      )
    end
    stations
    # pp stations
  end
end
