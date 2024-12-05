# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Testando validações de presença
  describe "Validações" do
    it "é válido com username e email" do
      user = build(:user, username: "valid_user", email: "valid_user@example.com")
      expect(user).to be_valid
    end

    it "não é válido sem username" do
      user = build(:user, username: nil, email: "valid_user@example.com")
      expect(user).to_not be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it "não é válido sem email" do
      user = build(:user, username: "valid_user", email: nil)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "não é válido com email duplicado" do
      create(:user, email: "duplicate_user@example.com")
      user = build(:user, email: "duplicate_user@example.com")
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end
  end
end
