Rails.application.routes.draw do
  root to: 'pages#welcome'
  devise_for :users
  resources :users, only: [:show] do
    resources :notes
  end
end
