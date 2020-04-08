# frozen_string_literal: true

# Model of stop of train
class Stop
  attr_accessor :trainid
  attr_accessor :number
  attr_accessor :code
  attr_accessor :arrival_time
  attr_accessor :stop_duration
  attr_accessor :distance

  def initialize(trainid, number, code, arrival_time, stop_duration, distance)
    @trainid = trainid
    @number = number
    @code = code
    @arrival_time = arrival_time
    @stop_duration = stop_duration
    @distance = distance
  end
end
