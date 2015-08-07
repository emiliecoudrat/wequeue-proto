class ChronosController < ApplicationController
  def create
    @line = Line.find(params[:id])
    @chrono = Chrono.new(line: @line, user: current_user, checked_in_at: DateTime.now)
    if @chrono.save
      redirect_to new_chrono_post_path(@chrono, Post.new)
      flash.keep[:alert] = "<i class='fa fa-check'><i> Vous venez de vous signaler dans la file d'attente #{@line.place.name}, le chronomètre de l'attente est lancé."
    else
      redirect_to line_path(@chrono.line)
      flash.keep[:alert] = "Le chrono n'a pas été lancé, réessayez !"
    end
  end

  def show
    @chrono = Chrono.find(params[:id])
  end

  def stop
    @chrono.checked_out_at = DateTime.now
    @chrono.save
  end
end
