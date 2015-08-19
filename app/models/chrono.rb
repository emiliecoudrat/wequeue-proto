# == Schema Information
#
# Table name: chronos
#
#  id                                 :integer          not null, primary key
#  user_id                            :integer
#  line_id                            :integer
#  checked_in_at                      :datetime
#  checked_out_at                     :datetime
#  manually_added_duration_in_minutes :integer
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  quit                               :boolean
#
# Indexes
#
#  index_chronos_on_line_id  (line_id)
#  index_chronos_on_user_id  (user_id)
#

class Chrono < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :line, dependent: :destroy
  has_many :posts

  validates :user, presence: true
  validates :line, presence: true
  validates :checked_in_at, presence: true

  def duration_since_checkin
    (Time.now - checked_in_at).seconds
  end

  def duration_in_string
    "#{(duration_since_checkin / 3600) < 10 ? "0" + (duration_since_checkin / 3600).floor.to_s : (duration_since_checkin / 3600).floor}:#{(duration_since_checkin % 3600 / 60) < 10 ? "0" + (duration_since_checkin % 3600 / 60).floor.to_s : (duration_since_checkin % 3600 / 60).floor}:#{((duration_since_checkin % 3600 % 60)) < 10 ? "0" + ((duration_since_checkin % 3600 % 60)).floor.to_s : ((duration_since_checkin % 3600 % 60)).floor}"
  end

  def total_duration
    if checked_out_at
      duration = (checked_out_at - checked_in_at)
    elsif manually_added_duration_in_minutes
      duration = manually_added_duration_in_minutes * 60
    else
      duration = nil
    end
    duration
  end

  def total_duration_in_minutes
    total_duration.fdiv(60).round(0)
  end

  def total_duration_in_string
    "#{(total_duration / 3600).floor}:#{(total_duration % 3600 / 60) < 10 ? "0" + (total_duration % 3600 / 60).floor.to_s : (total_duration % 3600 / 60).floor}:#{((total_duration % 3600 % 60)) < 10 ? "0" + ((total_duration % 3600 % 60)).floor.to_s : ((total_duration % 3600 % 60)).floor}" if total_duration
  end

  def hours
    if checked_out_at
      output = ((checked_out_at - checked_in_at) / 3600).floor
    else
      output = ((Time.now - checked_in_at) / 3600).floor
    end
    output
  end

  def minutes
    if checked_out_at
      output = (((checked_out_at - checked_in_at) - 3600 * hours) / 60).floor
    else
      output = (((Time.now - checked_in_at) - 3600 * hours) / 60).floor
    end
    output
  end

  def seconds
    if checked_out_at
      output = ((checked_out_at - checked_in_at) - 3600 * hours - 60 * minutes).floor
    else
      output = ((Time.now - checked_in_at) - 3600 * hours - 60 * minutes).floor
    end
    output
  end

  def done?
    total_duration ? true : false
  end

  def joke
    if total_duration_in_minutes <= 5
      joke = "le temps moyen d'un rapport sexuel chez les mouches tsé-tsé"
    elsif total_duration_in_minutes <= 10
      joke = "le temps de trop cuire un œuf à la coque"
    elsif total_duration_in_minutes <= 15
      joke = "le temps que met Depardieu à siffler trois bouteilles de rouge"
    elsif total_duration_in_minutes <= 20
      joke = "la durée du dernier album de Justin Bieber"
    elsif total_duration_in_minutes <= 25
      joke = "le temps que met Florent Manaudou pour traverser la Manche dans les deux sens à la nage"
    elsif total_duration_in_minutes <= 30
      joke = "le temps que met Paris Hilton pour claquer 20 000$ en Champagne dans une soirée"
    elsif total_duration_in_minutes <= 35
      joke = "le temps de faire trois stations sur la ligne 13 un lundi matin"
    elsif total_duration_in_minutes <= 40
      joke = "le temps que Gainsbourg mettait pour fumer son prmier paquet de clopes chaque matin"
    elsif total_duration_in_minutes <= 45
      joke = "le temps que met Le Père Fourras chaque soir pour retirer son dentier"
    elsif total_duration_in_minutes <= 50
      joke = "le temps que met pour Lance Armstrong pour monter le Mont Blanc avec double dose de dopage"
    elsif total_duration_in_minutes <= 55
      joke = "le temps moyen que mettent les Belges pour comprendre les blagues sur eux"
    elsif total_duration_in_minutes <= 60
      joke = "le temps moyen passé aux toilettes après avoir mangé un burito"
    elsif total_duration_in_minutes <= 70
      joke = "le temps qu'a pris le 322ème lifting de Cher (le plus rapide de l'année 2014)"
    elsif total_duration_in_minutes <= 80
      joke = "le temps de cuisson des dubitchous dans le Père Noël est une ordure (préalablement roulés sous les aisselles !!)"
    elsif total_duration_in_minutes <= 90
      joke = "le temps moyen que les Français dorment devant un film ukrainien."
    elsif total_duration_in_minutes <= 100
      joke = "le temps que met Madonna pour se ravaler la façade chaque matin"
    elsif total_duration_in_minutes <= 110
      joke = "la durée de cuisson d'une pizza bien trop cuite"
    elsif total_duration_in_minutes <= 120
      joke = "le temps que mettent les parisiens pour atteindre la petite couronne en voiture un vendredi soir"
    elsif total_duration_in_minutes <= 130
      joke = "le temps que les anglais passent chaque année à manger de la gelée"
    elsif total_duration_in_minutes <= 140
      joke = "le temps moyen que passe un italien à draguer chaque jour"
    else
      joke = "le temps que mettent les Russes avant de ressentir les premiers effets de l'alcool après avoir bu 2 bouteilles de Vodka"
    end
    joke
  end
end
