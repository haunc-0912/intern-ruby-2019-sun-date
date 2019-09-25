Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  root "static_pages#home"
  mount ActionCable.server => "/cable"

  resources :after_signup
  resources :dating_informations
  resources :images
  resources :matches, only: %i(index show destroy)

  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end

  resource :dating_criterias, only: %i(edit update)

  get "room_chat/index"
  get "dating_criterias/search_location", to: "dating_criterias#search_location"
  get "notifications/update", to: "notifications#update"

  resource :suggest_users, only: :show do
    get :react
  end

  resource :review_disliked_users, only: :show do
    get :react
  end

  resource :review_blocked_users, only: :show do
    get :react
  end

  resources :review_liked_me, only: %i(show index) do
    collection do
      get :react
    end
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "reset_password", to: "users/passwords#new"
    get "sign_up", to: "users/registrations#new"
  end

  get "review", to: "reviewed_dislike_users#review_disliked_users"
end
