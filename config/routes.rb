Blog::Application.routes.draw do
  get "sessions/new"
  resources :articles
  resources :users, only: [:index, :new, :create]
end
