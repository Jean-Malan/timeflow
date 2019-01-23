Rails.application.routes.draw do
  devise_for :users
  resources :tags
  resources :clients
  resources :time_cards
  root to: 'clients#index'
  get 'index/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :listings do
    member do
      patch  :move
    end
  end

  resources :clients do
    member do
      get :to_do
    end
  end

  resources :time_cards do
    member do
      patch  :edit
    end
  end

  resources :cards do
    member do
      patch  :move
      patch :edit
    end
  end
end
