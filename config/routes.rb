Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :update]
  resources :groups, except: [:index, :show, :destroy] do
    resources :messages, only: [:index, :create]
  end
  root  'groups#index'
end
