# spec/models/restaurant_spec.rb
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:user) { create(:user) }  # Cria um usuário para associar ao restaurante

  # Testando validações de presença
  describe "Validações" do
    it "é válido com nome e localização" do
      restaurant = build(:restaurant, name: "Valid Restaurant", location: "City Center", user: user)
      expect(restaurant).to be_valid
    end

    it "não é válido sem nome" do
      restaurant = build(:restaurant, name: nil, location: "City Center", user: user)
      expect(restaurant).to_not be_valid
      expect(restaurant.errors[:name]).to include("can't be blank")
    end

    it "não é válido sem localização" do
      restaurant = build(:restaurant, name: "Valid Restaurant", location: nil, user: user)
      expect(restaurant).to_not be_valid
      expect(restaurant.errors[:location]).to include("can't be blank")
    end

    it "não é válido sem um usuário associado" do
      restaurant = build(:restaurant, name: "Valid Restaurant", location: "City Center", user: nil)
      expect(restaurant).to_not be_valid
      expect(restaurant.errors[:user]).to include("must exist")
    end
  end

  # Testando associações
  describe "Associações" do
    it "pertence a um usuário" do
      restaurant = build(:restaurant, user: user)
      expect(restaurant.user).to eq(user)
    end

    it "tem muitos menus" do
      restaurant = create(:restaurant, user: user)
      menu = create(:menu, restaurant: restaurant)
      expect(restaurant.menus).to include(menu)
    end

    it "tem muitas avaliações" do
      restaurant = create(:restaurant, user: user)
      review = create(:review, restaurant: restaurant)
      expect(restaurant.reviews).to include(review)
    end
  end
end
