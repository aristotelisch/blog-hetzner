Blog::Application.routes.draw do
  root "articles#index"
  resources :articles
  resources :users, only: [:index, :new, :create]
  resource :session, only: [:new, :create, :destroy]

  get "/login" => "sessions#new", as: :login
  delete "/logout" => "sessions#destroy", as: :logout
  get "/search" => "search#search", as: :search
  get "/about" => "high_voltage/pages#show", id: "about"
  get "/contact" => "contacts#new", as: :contact
  resources :contacts, only: [:create]
end
