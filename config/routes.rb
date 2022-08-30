# frozen_string_literal: true

Rails.application.routes.draw do
  root 'items#index'
  get '/users', to: redirect('/users/edit')
  resources :admins, only: [:index] do
    collection do
      get :show_orders
      get :show_items
      get :show_categories
      get :show_restaurants
    end
  end

  resources :orders, only: %i[index show edit update]
  resources :items do
    member do
      post :add_to_cart, as: :add_to_cart
    end
  end

  resources :categories, only: %i[index new create show destroy]
  resources :restaurants, only: %i[index new create show destroy]

  resources :carts, only: [:index] do
    member do
      post :increase_quantity
      post :decrease_quantity
      delete :remove_cart_item, as: :remove_item
    end
    collection do
      get :checkout
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
