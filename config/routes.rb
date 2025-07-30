Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "demo_partial/new"
    get "demo_partial/edit"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    get "static_pages/help"
    get "static_pages/contact"

    get "signup", to: "users#new"
    post "signup", to: "users#create"

    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :password_resets, only: %i(new create edit update)
    resources :account_activations, only: :edit
    resources :microposts, only: %i(create destroy)
    resources :relationships, only: %i(create destroy)
  end
end
