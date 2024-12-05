FactoryBot.define do
  factory :review do
    rating { rand(1..5) }
    comment { Faker::Restaurant.review }
    restaurant # Associação com o restaurante
    user # Associação com o usuário
  end
end