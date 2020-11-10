Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/detail", to: "static_pages#detail"
    get "/order", to: "static_pages#order"
    get "signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users, only: [:new,:show, :create]
  end
end
