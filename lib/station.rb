# frozen_string_literal: true

# The model of station of train
class Station
  attr_accessor :code
  attr_accessor :title
  def initialize(code, title)
    @code = code
    @title = title
  end
end
