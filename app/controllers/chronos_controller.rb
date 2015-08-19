class ChronosController < ApplicationController
  before_action :set_chrono, except: :create

  def create
    @line = Line.find(params[:id])
    @chrono = Chrono.new(line: @line, user: current_user, checked_in_at: DateTime.now)
    if @line.has_a_running_chrono_with?(current_user)
      redirect_to chrono_path(@line.running_chrono_with(current_user))
    elsif current_user.running_chrono
      redirect_to chrono_path(current_user.running_chrono)
      flash.keep[:alert] = "Vous êtes déjà dans une file d'attente !"
    elsif @chrono.save
      redirect_to new_chrono_post_path(@chrono, Post.new)
      flash.keep[:alert] = "Vous venez de vous signaler dans la file d'attente #{@line.place.name}, le chronomètre de l'attente est lancé.".html_safe
    else
      redirect_to line_path(@chrono.line)
      flash.keep[:alert] = "Le chrono n'a pas été lancé, réessayez !"
    end
  end

  def show
  end

  def stop
    unless @chrono.checked_out_at
      @chrono.checked_out_at = DateTime.now
      @chrono.save
    end
  end

  def quit
    @chrono.quit = true
    if @chrono.save
      redirect_to thanks_path
    else
      render :stop
    end
  end

  def restart
    @chrono.checked_out_at = nil
    @chrono.save
    redirect_to chrono_path(@chrono)
  end

  def equivalence
  end

  def edit
    @chrono.checked_out_at = nil
    @chrono.save
  end

  def update
    if @chrono.update(chrono_params)
      redirect_to equivalence_chrono_path(@chrono)
    else
      render :edit
    end
  end

  private

  def set_chrono
    @chrono = Chrono.find(params[:id])
  end

  def chrono_params
    params.require(:chrono).permit(:manually_added_duration_in_minutes)
  end
end
