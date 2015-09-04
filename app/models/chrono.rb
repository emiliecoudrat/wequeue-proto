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

  def sentence_to_share_equivalence
    "J'ai attendu #{total_duration_in_string} à #{line.place.name} soit #{joke}"
  end

  def joke
    if total_duration_in_minutes <= 5
      joke = JOKES[0]
    elsif total_duration_in_minutes <= 10
      joke = JOKES[1]
    elsif total_duration_in_minutes <= 15
      joke = JOKES[2]
    elsif total_duration_in_minutes <= 20
      joke = JOKES[3]
    elsif total_duration_in_minutes <= 25
      joke = JOKES[4]
    elsif total_duration_in_minutes <= 30
      joke = JOKES[5]
    elsif total_duration_in_minutes <= 35
      joke = JOKES[6]
    elsif total_duration_in_minutes <= 40
      joke = JOKES[7]
    elsif total_duration_in_minutes <= 45
      joke = JOKES[8]
    elsif total_duration_in_minutes <= 50
      joke = JOKES[9]
    elsif total_duration_in_minutes <= 55
      joke = JOKES[10]
    elsif total_duration_in_minutes <= 60
      joke = JOKES[11]
    elsif total_duration_in_minutes <= 70
      joke = JOKES[12]
    elsif total_duration_in_minutes <= 80
      joke = JOKES[13]
    elsif total_duration_in_minutes <= 90
      joke = JOKES[14]
    elsif total_duration_in_minutes <= 100
      joke = JOKES[15]
    elsif total_duration_in_minutes <= 110
      joke = JOKES[16]
    elsif total_duration_in_minutes <= 120
      joke = JOKES[17]
    elsif total_duration_in_minutes <= 130
      joke = JOKES[18]
    elsif total_duration_in_minutes <= 140
      joke = JOKES[19]
    else
      joke = JOKES[20]
    end
    joke
  end
end
