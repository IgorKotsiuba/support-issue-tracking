Rails.application.routes.draw do
  devise_for :users
  root 'landing#show'

  resources :tickets, except: [:index, :destroy]
end
