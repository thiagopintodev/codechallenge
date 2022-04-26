Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: :show

  resources :posts do
    member do
      get 'remove'
    end
    resources :comments, shallow: true
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
