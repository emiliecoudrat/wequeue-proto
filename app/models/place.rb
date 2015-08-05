# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  address    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Place < ActiveRecord::Base
end
