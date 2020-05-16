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
  resources :tags, only: %i[index]
  get '/tag/:name', to: "tags#show"
  resources :repries, only: %i[create destroy]
  resources :relationships, only: %i[:create, :destroy]
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end