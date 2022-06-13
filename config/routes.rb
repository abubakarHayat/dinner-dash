Rails.application.routes.draw do
  resources :admins, only: [:index]
  # get 'items/new'
  # get 'items/create'
  # get 'items/update'
  # get 'items/edit'
  # get 'items/destroy'
  # get 'items/index'
  # get 'items/show'
  get 'items/see_items_admin', to: 'items#admin_show_items', as: 'admin_show_items'
  resources :items
  resources :categories, only: [:index]
  resources :restaurants, only: [:index, :new, :show]
  root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
