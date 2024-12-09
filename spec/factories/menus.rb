FactoryBot.define do
    factory :menu do
      name { Faker::Food.dish }
      description { Faker::Food.description }
      price { Faker::Commerce.price }
      restaurant # Associação com o restaurante
      user # Associação com o usuário
    end
  end
