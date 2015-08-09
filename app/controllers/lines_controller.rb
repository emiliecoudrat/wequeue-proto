class LinesController < ApplicationController
  before_action :set_line, only: :show

  def index
    if current_user.running_chrono
      redirect_to chrono_path(current_user.running_chrono)
    else
      @lines = Line.select { |line| line.creation_time_from_now_in_hours < 12 }
      @markers = Gmaps4rails.build_markers(@lines) do |line, marker|
        marker.lat line.place.latitude
        marker.lng line.place.longitude
      end
    end
  end

  def search
    @place = Place.find_or_create_by(name: search_params[:place].split(",").first, address: "#{search_params[:street_number]} #{search_params[:route]}, #{search_params[:postal_code]}") if search_params[:route]
    @line = Line.find_or_create_by(place: @place, created_at: (Time.now - 1.day)..Time.now) if search_params[:route]
    @line ? (redirect_to line_path(@line)) : (render :index)
  end

  def show
    @chronos = @line.chronos
    @chrono = Chrono.new
  end

  private

  def set_line
    @line = Line.find(params[:id])
  end

  def search_params
    params.permit(:utf8, :place, :latitude, :longitude, :street_number, :route, :postal_code, :locality, :country, :controller, :action)
  end
end
