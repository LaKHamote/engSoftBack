# Limpar o banco antes de semear
User.destroy_all
Restaurant.destroy_all
Menu.destroy_all
Review.destroy_all

# Criar usuários com nomes criativos
users = []
users_data = [
  { username: "FoodieFan", email: "foodiefan@example.com" },
  { username: "ChefMaster", email: "chefmaster@example.com" },
  { username: "TasteTester", email: "tastetester@example.com" },
  { username: "GastronomyGuru", email: "gastronomyguru@example.com" },
  { username: "CuisineCritic", email: "cuisinecritic@example.com" }
]

users_data.each do |user_data|
  users << User.create!(user_data)
end
puts "Criados #{users.size} usuários criativos!"

# Criar restaurantes com nomes inspirados
restaurants = []
restaurant_names = [
  "The Golden Spoon",
  "Savory Street",
  "Bistro Bon Appétit",
  "The Culinary Canvas",
  "Euphoria Eats"
]

restaurant_names.each do |name|
  restaurants << Restaurant.create!(
    user: users.sample,
    name: name,
    description: "#{name} é conhecido por seus pratos incríveis e ambiente acolhedor.",
    location: [ "New York", "Paris", "Tokyo", "São Paulo", "Sydney" ].sample
  )
end
puts "Criados #{restaurants.size} restaurantes únicos!"

# Criar menus com pratos criativos
menus = []
menu_items = [
  { name: "Truffle Bliss Pasta", description: "Massa fresca com trufas negras e parmesão.", price: 45.99 },
  { name: "Sushi Symphony", description: "Seleção premium de sushi e sashimi.", price: 65.50 },
  { name: "Smoky BBQ Ribs", description: "Costelas suculentas com molho barbecue artesanal.", price: 34.75 },
  { name: "Mediterranean Delight", description: "Prato mediterrâneo com cordeiro grelhado e vegetais.", price: 49.90 },
  { name: "Choco Lava Cake", description: "Bolo de chocolate com recheio derretido.", price: 12.50 }
]

10.times do
  menus << Menu.create!(
    restaurant: restaurants.sample,
    user: users.sample,
    name: menu_items.sample[:name],
    description: menu_items.sample[:description],
    price: rand(15.0..100.0).round(2)
  )
end
puts "Criados #{menus.size} pratos deliciosos!"

# Criar reviews com comentários criativos
reviews = []
review_comments = [
  "Uma explosão de sabores em cada mordida!",
  "A atmosfera é incrível, e a comida é ainda melhor.",
  "Definitivamente voltarei novamente!",
  "O prato principal foi divino, mas a sobremesa roubou o show!",
  "Excelente serviço e culinária de alto nível."
]

20.times do
  reviews << Review.create!(
    restaurant: restaurants.sample,
    user: users.sample,
    rating: rand(1..5),
    comment: review_comments.sample
  )
end
puts "Criados #{reviews.size} comentários apaixonados!"
