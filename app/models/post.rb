# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  chrono_id  :integer
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_posts_on_chrono_id  (chrono_id)
#

class Post < ActiveRecord::Base
  belongs_to :chrono

  validates :chrono, presence: true
end
