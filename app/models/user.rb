class User < ApplicationRecord
    has_many :restaurants, dependent: :destroy
    has_many :menus, dependent: :destroy
    has_many :reviews, dependent: :destroy

    validates :username, :email, presence: true
    validates :email, uniqueness: true

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.name = auth.info.name
            user.password = Devise.friendly_token[0, 20]
        end
    end
end
