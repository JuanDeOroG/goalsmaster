Rails.application.routes.draw do
  root to: "parameters#index"

  devise_for :users

  resources :parameters, only: [ :index, :create, :edit, :update ]
  resources :parameter_values, only: [ :index, :create, :edit, :update ]

  resources :roles, only: [ :index, :create, :edit, :update, :destroy ]
  resources :permissions, only: [ :index, :create, :edit, :update, :destroy ]
  post "/updateRolePermissions", to: "roles#updateRolePermissions" # Assign and remove permissions associated with a role.

  resources :goals, only: [ :index, :create, :edit, :update, :destroy ]
  resources :tasks, only: [ :index, :create, :edit, :update, :destroy ]
end
