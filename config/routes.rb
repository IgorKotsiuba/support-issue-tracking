Rails.application.routes.draw do
  root 'landing#show'

  devise_for :users, controllers: { sessions: 'admin/sessions' }, only: :sessions

  authenticated :users do
    root 'admin/tickets#index', as: :authenticated_root
  end

  namespace :admin do
    resources :tickets, except: [:create, :destroy] do
      resources :messages, only: :create
    end
  end

  resources :tickets, except: [:index, :destroy], param: :url_token do
    resources :messages, only: :create
  end
end
