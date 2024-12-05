class Menu < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :name, :restaurant, :user, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
