Rails.application.routes.draw do
  post "/authenticate", to: "authenticate#create"
  get "/logout", to: "authenticate#logout"

  get "/homepage", to: "homepage#index"

  root to: 'authenticate#login'
end
