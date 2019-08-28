Rails.application.routes.draw do
  root "static_pages#login"

  get "/signup", to: "static_pages#signup"
  get "static_pages_controller/home"
end
