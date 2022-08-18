Rails.application.routes.draw do
  # get 'orders/index'
  # get 'carts/index'
  resources :admins, only: [:index]
  root 'items#index'


  get 'items/show_items_admin', to: 'items#admin_show_items', as: 'admin_show_items'
  post 'items/add_to_cart/:id', to: 'items#add_to_cart', as: 'add_to_cart'
  post 'items/increase_quantity/:id', to: 'items#increase_quantity', as: 'increase_quantity'
  post 'items/decrease_quantity/:id', to: 'items#decrease_quantity', as: 'decrease_quantity'
  # post 'items/get_item_quantity/:id', to: 'items#get_item_quantity', as: 'get_item_quantity'
  get 'restaurants/show_restaurants_admin', to: 'restaurants#admin_show_restaurants', as: 'admin_show_restaurants'
  get 'items/cart_checkout', to: 'items#cart_checkout', as: 'cart_checkout'
  get 'orders/admin_show_orders', to: 'orders#admin_show_orders', as: 'admin_show_orders'
  resources :orders, only: [:index, :show, :edit, :update]
  resources :items
  get 'categories/show_categories_admin', to: 'categories#admin_show_categories', as: 'admin_show_categories'
  resources :categories, only: [:index, :new, :create, :show, :destroy]
  resources :restaurants, only: [:index, :new, :create, :show, :destroy]
  delete 'cart/items/:id', to: 'items#remove_cart_item', as: 'remove_cart_item'
  resources :carts, only: [:index]
  # scope 'carts' do
  #   delete 'items/:id', to: 'carts#remove_cart_item', as: 'remove_cart_item'
  # end
  # root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
