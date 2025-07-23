Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "microposts#index"  # Changed to show microposts on homepage

    get "demo_partial/new"
    get "demo_partial/edit"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    get "static_pages/home"
    get "static_pages/help"
    get "static_pages/contact"

    get "signup", to: "users#new"
    post "signup", to: "users#create"

    resources :users, only: %i(new create show)
    resources :microposts, only: [:index]
  end
end
