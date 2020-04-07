Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  resources :users
  resources :posts do
    resources :likes, only: %i[create destroy]
  end
  resources :repries, only: %i[create destroy]
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end