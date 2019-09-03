Rails.application.routes.draw do
  root "static_pages_controller#home"

  get "/login", to: "static_pages#login"
  get "/signup", to: "static_pages#signup"
  get "/set_dating", to: "static_pages#set_dating"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
end
