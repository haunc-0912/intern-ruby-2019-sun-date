Rails.application.routes.draw do
  root "static_pages#home"

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
end
