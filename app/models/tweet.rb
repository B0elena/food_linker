class Tweet < ApplicationRecord
  belongs_to :admin
  has_many :comments
  has_one_attached :image
  validates :tweet_name, :tweet_text, :image, presence: true

  def self.search(search)
    if search != ""
      Tweet.where('tweet_name LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end

  # def was_attached?
  #   self.image.attached?
  # end
end
