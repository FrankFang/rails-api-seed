Rails.application.routes.draw do
  resources :taggings
  resources :records
  resources :tags
  resources :password_resets, only: [:create]
  resource :password_reset_requests, only: [:create]
  resource :session, only: [:create, :destroy]
  resources :users, only: [:create, :show, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
