Rails.application.routes.draw do
  devise_for :users
  root 'landing#show'

  resources :tickets, except: [:index, :destroy], param: :url_token do
    resources :messages, only: :create
  end
end
