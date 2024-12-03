class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :menus, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, :location, presence: true
end
