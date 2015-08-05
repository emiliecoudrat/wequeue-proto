class Post < ActiveRecord::Base
  belongs_to :chrono

  validates :chrono, presence: true
end
