# frozen_string_literal: true

require 'tty-prompt'
require_relative '../lib/stops_reader'
require_relative '../lib/stations_reader'

def main
  p = StationsReader.new
  stations = p.read_stations(File.expand_path('../data/stations.csv', __dir__))

  p = StopsReader.new
  stops = p.read_stops(File.expand_path('../data/stops.csv', __dir__))

  invite(stops, stations)
end

def invite(stops, stations)
  prompt = TTY::Prompt.new
  choices = ['Вывести расписание движения поездов',
             'Вывести список поездов отсортировав их по количеству реальных остановок',
             'Завершить работу приложения']
  choice = prompt.enum_select('Выберите действие', choices)
  if choice == 'Вывести расписание движения поездов'
    rasspisanie_poezdov(stops, stations)
  elsif choice == 'Вывести список поездов отсортировав их по количеству реальных остановок'
    sort_spisok_poezdov(stops, stations)
  elsif choice == 'Завершить работу приложения'
    puts 'До свидания'
  end
end

def rasspisanie_poezdov(stops, stations)
  choices = []
  poezd = -1
  start_stantion = -1
  new_time = -1
  stantion = -1
  time = -1
  stops.stops.each do |stop|
    if stop.trainid != poezd
      if stantion != -1
        choices << "#{poezd}: #{stations.stations[start_stantion]}(#{new_time})   #{stations.stations[stantion]}(#{time})"
      end
      poezd = stop.trainid
      start_stantion = stop.code
      new_time = stop.arrival_time

    elsif stop.trainid == poezd
      stantion = stop.code
      time = stop.arrival_time
    end
  end
  if stantion != -1
    choices << "#{poezd}: #{stations.stations[start_stantion]}(#{new_time})   #{stations.stations[stantion]}(#{time})"
  end
  marshryt(choices, stops, stations)
end

def marshryt(choices, stops, stations)
  prompt = TTY::Prompt.new
  choice = prompt.enum_select('Выберите поезд', choices).slice(0..2)
  stops.stops.each do |stop|
    if stop.trainid == choice.to_i
      puts "#{stop.number}: #{stop.arrival_time} #{stations.stations[stop.code]}"
    end
  end
end

def sort_spisok_poezdov(stops, stations)
  new_array = {}
  count_real_stops = 0 # unreal stops
  count = 1 # All stops
  poezd = -1
  start_stantion = -1
  new_time = -1
  stantion = -1
  time = -1
  stops.stops.each do |stop|
    if stop.trainid != poezd
      if stantion != -1
        new_array[count_real_stops] = "Остановки: #{count} Маршрут: #{poezd}: #{stations.stations[start_stantion]}(#{new_time})   #{stations.stations[stantion]}(#{time})"
      end
      poezd = stop.trainid
      start_stantion = stop.code
      new_time = stop.arrival_time
      count_real_stops = 0
      count = 1
    elsif stop.trainid == poezd
      count_real_stops += 1 if stop.stop_duration != 0
      stantion = stop.code
      time = stop.arrival_time
      count += 1
    end
  end
  if stantion != -1
    new_array[count_real_stops] = "Остановки: #{count} Маршрут: #{poezd}: #{stations.stations[start_stantion]}(#{new_time})   #{stations.stations[stantion]}(#{time})"
  end
  sorted = new_array.sort_by do |key, _value|
    key.to_i
  end.to_h

  sorted.each_value do |value|
    puts value
  end
end

main if __FILE__ == $PROGRAM_NAME
