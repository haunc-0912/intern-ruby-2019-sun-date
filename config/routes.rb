Rails.application.routes.draw do
  root "static_pages#login"

  get "/signup", to: "static_pages#signup"
  get "static_pages_controller/home"
  get "/set_dating", to: "static_pages#set_dating"
end
