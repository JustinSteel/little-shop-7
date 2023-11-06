Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  namespace :admin do
    get "/", to: "dashboards#welcome"
  end

  resources :merchants do
    member do
      get "dashboard", action: :show
    end
    resources :items, controller: "merchant_items", param: :item_id, only: [:index, :show]
    resources :invoices, controller: "merchant_invoices", param: :invoice_id, only: [:index, :show]
    resources :invoice_items, controller: "merchant_invoice_items", param: :invoice_item, only: [:update]
  end
end
