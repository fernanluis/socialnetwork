Rails.application.routes.draw do

  resources :posts do
    resources :likes, only: %i[create]
  end

  resources :comments, only: %i[new create destroy] do
   resources :likes, only: %i[create]
  end

  resources :usuarios, as: :users, only: [:show, :update]
  resources :friendships, only: [:create, :update]

  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up" #is post because we create the register
  # root 'main#home'

  authenticated :user do
    root to: 'main#home', as: :root
  end

  unauthenticated :user do
    root to: 'main#unregistered', as: :unregistered_root
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
