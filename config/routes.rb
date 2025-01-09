Rails.application.routes.draw do
  resources :users
  resources :restaurants
  resources :menus
  resources :reviews

  # Adicionando rota para o callback do Google
  get 'auth/:provider/callback', to: 'sessions#google_auth'
  get 'auth/failure', to: redirect('/')
end
