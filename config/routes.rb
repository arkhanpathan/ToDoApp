Rails.application.routes.draw do
  resources :items do
    member do
      get :assign
      post :assign, to: "items#assign_item"
    end
  end
  get 'items/toggle_status/:id', to: "items#toggle_status", as: 'toggle_status'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "items#index"
end
