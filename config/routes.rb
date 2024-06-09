Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :tradelines do
    resources :deposits, only: [:index, :create]
  end
  resources :deposits, only: [:show]
end
