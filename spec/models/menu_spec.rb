# spec/models/menu_spec.rb
require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant, user: user) }
  let(:menu) { create(:menu, restaurant: restaurant, user: user) }

  # Validações
  describe "validations" do
    it "é válido com atributos válidos" do
      expect(menu).to be_valid
    end

    it "é inválido sem um nome" do
      menu.name = nil
      expect(menu).not_to be_valid
      expect(menu.errors[:name]).to include("can't be blank")
    end

    it "é inválido sem um preço" do
      menu.price = nil
      expect(menu).not_to be_valid
      expect(menu.errors[:price]).to include("can't be blank")
    end

    it "é inválido com preço negativo" do
      menu.price = -10.00
      expect(menu).not_to be_valid
      expect(menu.errors[:price]).to include("must be greater than or equal to 0")
    end

    it "é inválido sem um restaurante associado" do
      menu.restaurant = nil
      expect(menu).not_to be_valid
      expect(menu.errors[:restaurant]).to include("must exist")
    end

    it "é inválido sem um usuário associado" do
      menu.user = nil
      expect(menu).not_to be_valid
      expect(menu.errors[:user]).to include("must exist")
    end
  end

  # Associações
  describe "associations" do
    it "pertence a um restaurante" do
      association = Menu.reflect_on_association(:restaurant)
      expect(association.macro).to eq(:belongs_to)
    end

    it "pertence a um usuário" do
      association = Menu.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
