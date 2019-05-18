Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: :new
  end
  resources :albums, except: :new do
    resources :tracks, only: :new
  end
  resources :tracks, except: :new do
    resources :notes, only: [:create, :edit, :update, :destroy]
  end
  root "bands#index"
end
