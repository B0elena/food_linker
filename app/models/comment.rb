class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  validates :comment_text, presence: true
end
