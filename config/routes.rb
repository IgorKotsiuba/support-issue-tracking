Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'admin/sessions' }, only: :sessions

  authenticated :user do
    root 'admin/tickets#index', as: :authenticated_root
  end

  root 'landing#show'

  namespace :admin do
    resources :tickets, only: [:index, :show] do
      resources :messages, only: :create
    end
  end

  resources :tickets, except: [:index, :destroy], param: :url_token do
    resources :messages, only: :create
  end
end
