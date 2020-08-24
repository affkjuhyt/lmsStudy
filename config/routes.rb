Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root 'home#index'

    get "/about", to: "home#about"
    resources :courses
    # Ex:- scope :active, -> {where(:active => true)}
    devise_for :users, skip: :omniauth_callbacks, controllers: { sessions: "sessions" }
    resources :categories
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
end
