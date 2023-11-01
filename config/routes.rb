Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  namespace :admin do
    get "/", to: "dashboards#welcome"
  end

  resources :merchants, param: :id do
    resources :items, controller: "merchant_items", only: [:index]
    resources :invoices, controller: "merchant_invoices", only: [:index, :show]
    get "dashboard", on: :member, action: :show
  end
end
