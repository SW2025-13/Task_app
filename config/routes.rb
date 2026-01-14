Rails.application.routes.draw do
  # トップページ（最初のページ）
  root "home#index"

  # もし /top でも見せたいなら（任意）
  # get "/top", to: "home#index", as: "top"

  resources :users, only: [:new, :create]

  # ログイン関連
  get    "/login",  to: "sessions#new",     as: "login"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # ログイン後専用
  resources :tasks do
    member do
      post "toggle_done"
    end
  end
end
