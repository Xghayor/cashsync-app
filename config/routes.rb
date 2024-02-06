Rails.application.routes.draw do
  devise_for :users

  root to: "static_pages#home"

  resources :users do
    resources :groups do
      resources :entities
    end
  end
end
