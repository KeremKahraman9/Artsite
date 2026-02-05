Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :artworks do
    resources :auctions, only: [:new, :create]
  end

  resources :auctions, only: [:index, :show] do
    resources :bids, only: [:create]
    member do
      post :watch
      delete :unwatch
    end
  end

  resources :categories, only: [:show]

  get "dashboard", to: "dashboard#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
