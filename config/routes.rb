Blog::Application.routes.draw do
  root "articles#index"
  resources :articles
  get "/login" => "sessions#new", as: :login 
  delete "/logout" => "sessions#destroy", as: :logout
  get "/about" => "high_voltage/pages#show", id: "about"
  resources :users, only: [:index, :new, :create]
  resource :session, only: [:new, :create, :destroy]

  get "/search" => "search#search", as: :search
end
