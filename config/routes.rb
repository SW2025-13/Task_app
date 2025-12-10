Rails.application.routes.draw do
  root "tasks#index"

  get "/top", to: "top#index", as: "top"

  resources :users, only: [:new, :create]

  # ログイン
  get  '/login',  to: 'sessions#new',     as: 'login'
  post '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :tasks do
    member do
      post "toggle_done"
    end
  end
end

