Rails.application.routes.draw do
  get 'pages/search'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/home", to: "static_pages#index"
    get "signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "pages/search", to: "pages#search", as: "search_page"
    resources :users, except: %i(destroy index )
    resources :static_pages, only: %i(index show)
    namespace :admin do
      resources :bookings, only: %i(index update)
      resources :locations, except: %i(delete show)
    end
  end
end
