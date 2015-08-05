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
  belongs_to :place
end
