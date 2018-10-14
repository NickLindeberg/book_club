Rails.application.routes.draw do

  resources :books, only: [:index, :show, :destroy, :create, :new]

  resources :authors, only: [:show, :destroy]

  resources :users, only: [:show] do
    resources :reviews, only: [:index, :destroy]
  end

  resources :reviews, only: [:create, :new]
end
