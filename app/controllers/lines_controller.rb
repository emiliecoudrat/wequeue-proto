class LinesController < ApplicationController
  before_action :set_line, exept: :index
  def index
    @lines = Line.find_each { |line| line.creation_time_from_now_in_hours < 12 }
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
