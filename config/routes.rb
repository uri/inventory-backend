Rails.application.routes.draw do

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    resources :categories, only: [:index, :create, :show, :update, :destroy]
    resources :items, only: [:index, :create, :show, :update, :destroy]
    resources :reservations, only: [:index, :create]
    resources :checkouts, only: [:create, :update]
  end

  resources :categories, only: :index
  resources :reservations, only: :index
end
