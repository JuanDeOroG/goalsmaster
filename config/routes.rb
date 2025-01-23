Rails.application.routes.draw do
  root to: "parameters#index"

  devise_for :users

  resources :parameters, only: [ :index, :show, :new, :create, :edit, :update ]
  resources :parameter_values, only: [ :index, :show, :new, :create, :edit, :update ]

  resources :roles, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  resources :permissions, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
end
