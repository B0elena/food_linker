class Event < ApplicationRecord
  belongs_to :admin
  validates :event_name, :event_text, :prefecture, :city, :block, :date, :phone, presence: true
end
