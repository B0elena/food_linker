class Tweet < ApplicationRecord
  belongs_to :admin
  has_one_attached :image
  validates :tweet_name, :tweet_text, :image, presence: true
end
