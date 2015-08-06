class LinesController < ApplicationController
  def index
    @lines = Line.find_each { |line| line.creation_time_from_now_in_hours < 12 }
  end
end
