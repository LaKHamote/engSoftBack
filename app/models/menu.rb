class Menu < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :name, :price, presence: true
end
