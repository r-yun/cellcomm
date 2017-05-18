Rails.application.routes.draw do

  root :to => "phones#index"
  get "carts/cart", :as => "cart_page"
  get "/login/logout", :as => "logout"
  get "/login/login_page", :as => "login_page"
  post "carts/create_cart", :as => "create_cart"
  post "/login/authentication", :as => "authentication"
  post "/phones/search_results", :to => "phones#search_results", :as => "search_results"
  post "/phones/search_button", :as => "search_button"
  resources :users, :only => [:new, :create]
  resources :carts, :only => [:create]
  resources :phones, :only => [:index, :show]



end
