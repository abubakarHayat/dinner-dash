Rails.application.routes.draw do
  resources :admins, only: [:index]
  root 'items#index'

  get 'items/show_items_admin', to: 'items#admin_show_items', as: 'admin_show_items'
  post 'items/add_to_cart/:id', to: 'items#add_to_cart', as: 'add_to_cart'
  post 'cart/items/increase_quantity/:id', to: 'carts#increase_quantity', as: 'increase_quantity'
  post 'cart/items/decrease_quantity/:id', to: 'carts#decrease_quantity', as: 'decrease_quantity'
  get 'restaurants/show_restaurants_admin', to: 'restaurants#admin_show_restaurants', as: 'admin_show_restaurants'
  get 'cart/cart_checkout', to: 'carts#cart_checkout', as: 'cart_checkout'
  get 'orders/admin_show_orders', to: 'orders#admin_show_orders', as: 'admin_show_orders'
  resources :orders, only: [:index, :show, :edit, :update]
  resources :items
  get 'categories/show_categories_admin', to: 'categories#admin_show_categories', as: 'admin_show_categories'
  resources :categories, only: [:index, :new, :create, :show, :destroy]
  resources :restaurants, only: [:index, :new, :create, :show, :destroy]
  delete 'cart/items/:id', to: 'carts#remove_cart_item', as: 'remove_cart_item'
  resources :carts, only: [:index]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
