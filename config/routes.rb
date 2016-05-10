Rails.application.routes.draw do
  root "staticpages#home"
  get "about" => "staticpages#about"
  get "contact" => "staticpages#contact"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users
  resources :relationships, only: [:create, :destroy]
  resources :words, only: [:index]
  resources :courses, only: [:index, :show] do
    resources :lessons, except: [:index, :destroy, :edit]
  end

  namespace :admin do
    root "courses#index"
    resources :courses do
      resources :words
    end
  end
end
