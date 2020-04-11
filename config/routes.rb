Rails.application.routes.draw do
  
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :likes, only: %i[create destroy]
  end
  resources :repries, only: %i[create destroy]
  resources :relationships, only: [:create, :destroy]
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end