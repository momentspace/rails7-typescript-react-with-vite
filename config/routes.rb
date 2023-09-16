Rails.application.routes.draw do
  root :to => 'dashboard#index'
  get 'dashboard', to: "dashboard#index"
  get 'dashboard/new', to: "dashboard#new"
  get "home", to: "home#index"
  devise_for :users
end
