class Prize < ApplicationRecord
  validates :duration, :price, :title, presence: true
  validates :duration, :price, numericality: { greater_than: 0 }
end
