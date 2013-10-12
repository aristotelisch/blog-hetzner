Blog::Application.routes.draw do
  root to: "articles#index"
  resources :articles
  get "/login" => "sessions#new", as: :login 
  delete "/logout" => "sessions#destroy", as: :logout
  resources :users, only: [:index, :new, :create]
  resource :session, only: [:new, :create, :destroy]
end
