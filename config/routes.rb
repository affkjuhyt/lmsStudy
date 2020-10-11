Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => "/cable"
  scope "(:locale)", locale: /en|vi/ do
    root 'home#index'

    get "/about", to: "home#about"
    resources :courses do
      resources :lessons do
        get :next_lesson, on: :collection
      end
    end
    resources :questions
    resources :answers, only: :create
    resources :exams
    resources :question_choices
    resources :user_courses, only: [:create, :edit, :update]
    resources :review_courses, except: [:new, :show]
    resources :chats, only: :index
    resources :messages,except: [:index, :show, :edit]
    resources :notifications do
      collection do
        post :mark_as_read
      end
    end

    post "course/rate/:course_id", to: "rates#save_rate", as: :rate_course
    # Ex:- scope :active, -> {where(:active => true)}
    devise_for :users, skip: :omniauth_callbacks, controllers: { sessions: "sessions" }
    resources :categories

    namespace :admin do
      get "/", to: "base#index"
      resources :users
      devise_scope :user do
        get "/login", to: "sessions#new"
        post "/login", to: "sessions#create"
        delete "/logout", to: "sessions#destroy"
      end
      resources :courses
    end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
end
