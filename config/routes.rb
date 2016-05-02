Rails.application.routes.draw do
  root "staticpages#home"
  get "about" => "staticpages#about"
  get "contact" => "staticpages#contact"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users

  namespace :admin do
    resources :courses, only: [:index, :create, :new]
  end
end
