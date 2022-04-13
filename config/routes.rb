Rails.application.routes.draw do
  get 'user/root'
  get 'guest/root'
  get 'home/root'
  root 'root#root'

  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
