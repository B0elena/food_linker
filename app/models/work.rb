class Work < ApplicationRecord
  belongs_to :admin
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :employment_status
  validates :shop_name, :employment_status_id, :work_name, :work_text, :phone, presence: true
  validates :employment_status_id, numericality: { other_than: 1 } 
  PRICE_REGEX = /\A[0-9]+\z/.freeze
  validates :phone, format: { with: PRICE_REGEX }
end
