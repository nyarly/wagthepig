Rails.application.routes.draw do
  devise_for :users
  resources :games, except: :index
  resources :events
  resources :interests, only: %i[create edit update destroy]
  root to: "home#index"
end
