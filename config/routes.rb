Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "microposts#index"  # Changed to show microposts on homepage

    get "demo_partial/new"
    get "demo_partial/edit"
    get "static_pages/home"
    get "static_pages/help"
    get "static_pages/contact"

    resources :microposts, only: [:index]
  end
end
