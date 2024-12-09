# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      username { "user_#{Faker::Internet.unique.username}" } # Gera um nome de usuário único
      email { Faker::Internet.unique.email } # Gera um e-mail único
      created_at { Time.now }
      updated_at { Time.now }
    end
  end
