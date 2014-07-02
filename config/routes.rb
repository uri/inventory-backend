Rails.application.routes.draw do

  devise_for :users

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    resources :categories, only: [:index, :create, :show, :update, :destroy]
    resources :items, only: [:index, :create, :show, :update, :destroy] do
      member do
        post 'checkout'
      end
    end
    resources :reservations, only: [:index, :create]
  end

  resources :categories, only: :index
  resources :reservations, only: :index
end
