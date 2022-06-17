Rails.application.routes.draw do
  get 'carts/index'
  resources :admins, only: [:index]
  root 'items#index'
  # get 'items/new'
  # get 'items/create'
  # get 'items/update'
  # get 'items/edit'
  # get 'items/destroy'
  # get 'items/index'
  # get 'items/show'
  get 'items/show_items_admin', to: 'items#admin_show_items', as: 'admin_show_items'
  get 'restaurants/show_restaurants_admin', to: 'restaurants#admin_show_restaurants', as: 'admin_show_restaurants'
  resources :items
  resources :categories, only: [:index]
  resources :restaurants, only: [:index, :new, :show, :destroy]
  resources :carts, only: [:index]
  # root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
