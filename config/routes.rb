Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :games, except: :index
  resources :events

  resource :suggestion, only: %i[new show]
  resolve('Suggestion') { [:suggestion] }

  resource :shared_interests, only: %i[show]

  resources :interests, only: %i[create edit update destroy]
  root to: "home#index"
end
