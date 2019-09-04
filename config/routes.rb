Rails.application.routes.draw do
  get 'room_chat/index'
  root "static_pages#home"
  mount ActionCable.server => "/cable"

  resources :dating_informations
  resources :images
  resources :matches, only: %i(index show)

  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end

  resource :dating_criterias, only: %i(edit update)

  get "dating_criterias/search_location", to: "dating_criterias#search_location"

  resource :suggest_users, only: :show do
    get :react
  end

  resource :review_disliked_users, only: :show do
    get :react
  end

  resource :review_blocked_users, only: :show do
    get :react
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
