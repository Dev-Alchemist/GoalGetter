Rails.application.routes.draw do
  devise_for :users

  resources :goals do
    resource :completed, controller: :goal_completed, only: [:create]
  end
  resources :incomplete_goals, only: [:index]
  resources :completed_goals, only: [:index]
  get "about", to: "about#index"
  root "about#index"
end
