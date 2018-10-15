Rails.application.routes.draw do


  #! TODO: consider nesting 
  #! reviews#create, reviews#new
  #! inside of :books

  resources :books, only: [:index, :show, :destroy, :create, :new]

  resources :authors, only: [:show, :destroy]

  resources :users, only: [:show] do
    resources :reviews, only: [:index, :destroy]
  end

  resources :reviews, only: [:create, :new]
end
