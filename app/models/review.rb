class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :rating, :restaurant, :user, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, length: { maximum: 500 }, allow_blank: true
  validates :restaurant, presence: true
  validates :user, presence: true
end
