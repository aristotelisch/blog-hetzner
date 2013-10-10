Blog::Application.routes.draw do
  root to: "articles#index"
  resources :articles
  resources :users, only: [:index, :new, :create]
  resource :session, only: [:new, :create, :destroy]
end
