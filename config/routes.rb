Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    # Ex:- scope :active, -> {where(:active => true)}
    devise_for :users
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
