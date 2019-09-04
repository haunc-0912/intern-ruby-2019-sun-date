Rails.application.routes.draw do
  root "static_pages#home"
  mount ActionCable.server => "/cable"

  resources :dating_informations
  resources :images
  resources :matches, only: %i(index show)
  resource :dating_criterias, only: %i(edit update)

  get "dating_criterias/search_location", to: "dating_criterias#search_location"

  resource :suggest_users, only: :show do
    get :react
  end
  resources :images

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
