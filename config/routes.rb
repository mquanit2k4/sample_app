Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :products
    get "demo_partial/new"
    get "demo_partial/edit"
    get "static_pages/home"
    get "static_pages/help"
    resources :users
    root "static_pages#home"
  end

  # Redirect root path to default locale
  root to: redirect("/#{I18n.default_locale}")
end
