class LinesController < ApplicationController
  before_action :set_line, except: :index
  def index
    @lines = Line.find_each { |line| line.creation_time_from_now_in_hours < 12 }
    @markers = Gmaps4rails.build_markers(@lines) do |line, marker|
      marker.lat line.place.latitude
      marker.lng line.place.longitude
    end
  end

  def search

  end

  def show
    @chronos = @line.chronos
    @posts = []
    @chronos.each do |chrono|
      @posts << chrono.posts
    end
    @posts.flatten!
  end

  private

  def set_line
    @line = Line.find(params[:id])
  end
end
