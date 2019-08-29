Rails.application.routes.draw do
  root "static_pages#login"

  get "/signup", to: "static_pages#signup"
end
