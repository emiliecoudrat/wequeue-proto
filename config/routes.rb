Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # roots
  authenticated :user do
    root to: "lines#index", as: :authenticated_root
  end
  root to: "pages#home"

  # resources
  resources :users, only: :show
  resources :lines, only: :show do
    member do
      resources :chronos, only: :create
    end
  end

  # other routes
  get 'chronos/:chrono_id/posts/new', to: "posts#new", as: :new_chrono_post
  post 'chronos/:chrono_id/posts', to: "posts#create", as: :chrono_posts
  get 'search', to: "lines#search", as: :search_line
  resources :chronos, only: :show
  get 'chronos/:id/stop', to: "chronos#stop", as: :stop_chrono
end
