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
end
