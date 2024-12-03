Rails.application.routes.draw do
  resources :users
  resources :restaurants
  resources :menus
  resources :reviews
end
