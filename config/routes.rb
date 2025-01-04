Rails.application.routes.draw do
  root to: "parameters#index"

  # devise_for :user

  resources :parameters, only: [ :index, :show, :new, :create, :edit, :update ]
  resources :parameter_values, only: [ :index, :show, :new, :create, :edit, :update ]
end
