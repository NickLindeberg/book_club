Rails.application.routes.draw do

  resources :books, only: [:index, :show, :destroy, :create, :new]

end
