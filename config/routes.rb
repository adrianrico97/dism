Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :home
  resources :accounts, only: [:new, :create]
  resources :users
  resources :users do
    member do
      post :activate
      post :deactivate
    end
  end

end
