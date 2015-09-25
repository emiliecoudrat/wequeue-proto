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
    chronos.select { |chrono| chrono.done? && !chrono.quit }.sort_by(&:updated_at).last.total_duration.fdiv(60).floor if chronos.first && chronos.select { |chrono| chrono.done? && !chrono.quit }.sort_by(&:updated_at).last
  end

  def long_waiting_time
    "#{waiting_time / 60}h#{waiting_time % 60}"
  end

  def has_a_running_chrono_with?(user)
    chronos.map { |chrono| chrono.user unless chrono.done? }.include?(user)
  end

  def running_chrono_with(user)
    chronos.select { |chrono| chrono.user == user && !chrono.done? }.first
  end

  def running_chronos
    chronos.select { |chrono| !chrono.done? && !chrono.quit }
  end

  def running_chronos_data
    output = []
    running_chronos.each do |chrono|
      output << [chrono.id, chrono.hours, chrono.minutes, chrono.seconds]
    end
    output
  end
end
