Blog::Application.routes.draw do
  resources :articles
  resources :users, only: [:index, :new, :create]
end
