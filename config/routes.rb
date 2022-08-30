Rails.application.routes.draw do
  resources :admins, only: [:index]
  root 'items#index'

  resources :orders, only: %i[index show edit update] do
    collection do
      get :admin_show_orders, as: :admin_show
    end
  end
  resources :items do
    member do
      post :add_to_cart, as: :add_to_cart
    end
    collection do
      get :admin_show_items, as: :admin_show
    end
  end

  resources :categories, only: %i[index new create show destroy] do
    collection do
      get :admin_show_categories, as: :admin_show
    end
  end
  resources :restaurants, only: %i[index new create show destroy] do
    collection do
      get :admin_show_restaurants, as: :admin_show
    end
  end

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
