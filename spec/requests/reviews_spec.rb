require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant, user: user) }
    let(:review) { build(:review, restaurant: restaurant, user: user) }

    it "é inválido sem uma avaliação (rating)" do
      review.rating = nil
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("can't be blank")
    end

    it "é inválido se a avaliação não for um número" do
      review.rating = "not_a_number"
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

    it "é válido com uma avaliação entre 1 e 5" do
      review.rating = 4
      expect(review).to be_valid
    end
  end
end
