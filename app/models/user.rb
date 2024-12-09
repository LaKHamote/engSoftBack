class User < ApplicationRecord
    has_many :restaurants, dependent: :destroy
    has_many :menus, dependent: :destroy
    has_many :reviews, dependent: :destroy

    validates :username, :email, presence: true
    validates :email, uniqueness: true
end
