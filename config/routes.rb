Rails.application.routes.draw do
  root "home#index"
  get 'home', to: "home#index"
  get 'home/:page', to: "home#index"
  get 'test', to: "test#index"
end
