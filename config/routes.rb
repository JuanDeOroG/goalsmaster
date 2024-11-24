Rails.application.routes.draw do
  resources :parameters, only: [ :index, :show, :new, :create, :edit, :update ]
end
