Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  authenticated :user do
    root to: "lines#index", as: :authenticated_root
  end
  root to: "pages#home"
  resources :users, only: :show
  resources :lines, only: [:create, :show, :update]
  get 'search', to: "lines#search", as: :search_line
end
