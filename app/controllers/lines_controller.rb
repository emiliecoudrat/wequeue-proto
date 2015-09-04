class LinesController < ApplicationController
  before_action :set_line, only: :show

  def index
    if current_user.running_chrono
      flash.now[:alert] = "Vous êtes déjà dans une file d'attente !"
    end
    @lines = Line.select { |line| line.creation_time_from_now_in_hours < 12 && line.chronos.size > 0 }
    @markers = Gmaps4rails.build_markers(@lines) do |line, marker|
      marker.lat line.place.latitude
      marker.lng line.place.longitude
      if line.waiting_time.nil?
        marker.picture url: ActionController::Base.helpers.asset_path("grey-steps.png"), width: 35, height: 34
        marker.infowindow "
          <div class='infowindow' style='background-color:#4A4A4A'>
            <a class='close-white'><span>&times;</span></a>
            <a href='#{line_path(line)}'>
              <div class='title'>#{line.place.name}</div>
              <div class='waiting-time'>Pas d'estimation</div>
            </a>
          </div>
        "
      elsif line.waiting_time > 60
        marker.picture url: ActionController::Base.helpers.asset_path("red-steps.png"), width: 35, height: 34
        marker.infowindow "
          <div class='infowindow' style='background-color:#FF5556'>
            <a class='close-white'><span>&times;</span></a>
            <a href='#{line_path(line)}'>
              <div class='title'>#{line.place.name}</div>
              <div class='waiting-time'>#{line.waiting_time} min</div>
            </a>
          </div>
        "
      elsif line.waiting_time > 30
        marker.picture url: ActionController::Base.helpers.asset_path("orange-steps.png"), width: 35, height: 34
        marker.infowindow "
          <div class='infowindow' style='background-color:#F58823'>
            <a class='close-white'><span>&times;</span></a>
            <a href='#{line_path(line)}'>
              <div class='title'>#{line.place.name}</div>
              <div class='waiting-time'>#{line.waiting_time} min</div>
            </a>
          </div>
        "
      else
        marker.picture url: ActionController::Base.helpers.asset_path("green-steps.png"), width: 35, height: 34
        marker.infowindow "
          <div class='infowindow' style='background-color:#248F2E'>
            <a class='close-white'><span>&times;</span></a>
            <a href='#{line_path(line)}'>
              <div class='title'>#{line.place.name}</div>
              <div class='waiting-time'>#{line.waiting_time} min</div>
            </a>
          </div>
        "
      end
    end
  end

  def search
    @place = Place.find_or_create_by(name: search_params[:place].split(",").first, address: "#{search_params[:street_number]} #{search_params[:route]}, #{search_params[:postal_code]} #{search_params[:locality]}") if search_params[:route]
    @line = Line.find_or_create_by(place: @place, created_at: (Time.now - 0.5.day)..Time.now) if search_params[:route]
    @line ? (redirect_to line_path(@line)) : (render :index)
  end

  def show
    @chronos = @line.chronos.sort_by(&:created_at).reverse
    @chrono = Chrono.new
    @older_lines = @line.place.lines.where("created_at >=?", DateTime.now - 8).reject { |line| line == @line }
    @older_chronos = []
    @older_lines.each do |line|
      @older_chronos << line.chronos
    end
    @older_chronos = @older_chronos.flatten.sort_by(&:created_at).reverse
  end

  private

  def set_line
    @line = Line.find(params[:id])
  end

  def search_params
    params.permit(:utf8, :place, :latitude, :longitude, :street_number, :route, :postal_code, :locality, :country, :controller, :action)
  end
end
