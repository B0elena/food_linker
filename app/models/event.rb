class Event < ApplicationRecord
  belongs_to :admin
  validates :event_name, :event_text, :prefecture, :city, :block, :date, :phone, presence: true
  PRICE_REGEX = /\A[0-9]+\z/.freeze
  validates :phone, format: { with: PRICE_REGEX }
end
