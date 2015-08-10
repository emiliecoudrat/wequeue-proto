# == Schema Information
#
# Table name: lines
#
#  id         :integer          not null, primary key
#  place_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_lines_on_place_id  (place_id)
#

class Line < ActiveRecord::Base
  belongs_to :place, dependent: :destroy
  has_many :chronos

  validates :place, presence: true

  def creation_time_from_now_in_hours
    (Time.now - created_at).fdiv(3600)
  end

  def has_at_least_one_checkout?
    chronos.select { |chrono| chrono.done? }.size > 0 ? true : false
  end

  def waiting_time
    chronos.select { |chrono| chrono.done? }.sort_by(&:checked_out_at).last.total_duration.fdiv(60).floor if chronos.first
  end

  def has_a_running_chrono_with?(user)
    chronos.map { |chrono| chrono.user unless chrono.done? }.include?(user)
  end

  def running_chrono_with(user)
    chronos.select { |chrono| chrono.user == user }.first
  end
end
