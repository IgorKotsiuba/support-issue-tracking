Rails.application.routes.draw do
  resources :tickets, except: [:index, :destroy], param: :url_token do
    resources :messages, only: :create
  end

  devise_for :users, controllers: { sessions: 'admin/sessions' }

  namespace :admin do
    resources :tickets, except: [:create, :destroy] do
      resources :messages, only: :create
    end
  end

  root 'landing#show'
end
