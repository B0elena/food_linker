class Tweet < ApplicationRecord
  belongs_to :admin
  has_one_attached :image
end
