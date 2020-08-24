Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root 'home#index'

    get "/about", to: "home#about"
    resources :courses
    resources :user_courses, only: [:create, :edit, :update]
    resources :review_courses, except: [:new, :show]
    get "course/rate/:course_id", to: "rates#save_rate", as: :rate_course  
    # Ex:- scope :active, -> {where(:active => true)}
    devise_for :users, skip: :omniauth_callbacks, controllers: { sessions: "sessions" }
    resources :categories
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
end
