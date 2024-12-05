# spec/models/review_spec.rb
require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant, user: user) }
  let(:review) { create(:review, restaurant: restaurant, user: user) }

  # Validações
  describe "validations" do
    it "é válido com atributos válidos" do
      expect(review).to be_valid
    end

    it "é inválido sem uma avaliação (rating)" do
      review.rating = nil
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("can't be blank")
    end

    it "é inválido se a avaliação não for um número" do
      review.rating = "não é número"
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("is not a number")
    end

    it "é inválido se a avaliação for menor que 1" do
      review.rating = 0
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be greater than or equal to 1")
    end

    it "é inválido se a avaliação for maior que 5" do
      review.rating = 6
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be less than or equal to 5")
    end

    it "é válido sem um comentário" do
      review.comment = nil
      expect(review).to be_valid
    end

    it "é inválido sem um restaurante associado" do
      review.restaurant = nil
      expect(review).not_to be_valid
      expect(review.errors[:restaurant]).to include("must exist")
    end

    it "é inválido sem um usuário associado" do
      review.user = nil
      expect(review).not_to be_valid
      expect(review.errors[:user]).to include("must exist")
    end
  end

  # Associações
  describe "associations" do
    it "pertence a um restaurante" do
      association = Review.reflect_on_association(:restaurant)
      expect(association.macro).to eq(:belongs_to)
    end

    it "pertence a um usuário" do
      association = Review.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
