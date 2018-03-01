Rails.application.routes.draw do


  get 'pages/home'

  devise_for :registrations

  root to: 'pages#home'

  resources :users

  resources :jobs, only: [:show] do
    resources :favorites, only: [:create]
    resources :applications, only: [:create]
  end

  resources :favorites, only: [:destroy]

  resources :applications, only: [:update, :destroy] do
    member do
      patch 'rejected'
      patch 'in_progress'
      patch 'matched'
    end
  end

  resources :dashboard, only: [:index]

end
