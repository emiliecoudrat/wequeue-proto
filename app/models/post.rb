# == Schema Information
#
# Table name: posts
#
#  id                   :integer          not null, primary key
#  chrono_id            :integer
#  content              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#
# Indexes
#
#  index_posts_on_chrono_id  (chrono_id)
#

class Post < ActiveRecord::Base
  belongs_to :chrono

  validates :chrono, presence: true

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/
end
