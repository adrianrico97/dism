Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :home

  resources :users

  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :accounts, only: [:new, :create, :edit, :update]

  resources :users do
    member do
      post :activate
      post :deactivate
    end
  end

  resources :brands do
    resources :models
  end

  resources :programs

  resources :devices do
    collection do
      get :models_for_select_brand
    end
    member do
      get :assign
      post :save_assign
      get :deassign
      post :save_deassign
    end
    resources :issues do
      resources :trackings, only: [:new, :create]
    end
  end

end
