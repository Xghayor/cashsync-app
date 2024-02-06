Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'users#show', as: :authenticated_root
  end

  root to: "static_pages#home"

  resources :users do
    resources :groups do
      resources :entities
    end
  end
end
