Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  namespace :admin do
    get "/", to: "dashboards#welcome"
    resources :merchants, only: [:show, :index]
  end

  resources :merchants, param: :id do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
    get "dashboard", on: :member, action: :show
  end
end
