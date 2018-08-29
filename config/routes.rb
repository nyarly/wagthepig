Rails.application.routes.draw do
  devise_for :users
  resources :games, except: :index
  resources :events
  root to: "home#index"
end
