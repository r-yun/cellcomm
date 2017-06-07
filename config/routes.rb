Rails.application.routes.draw do

  root :to => "phones#index"
  get "carts/cart", :as => "cart_page"
  get "carts/checkout", :as => "checkout"
  get "/login/logout", :as => "logout"
  get "/login/login_page", :as => "login_page"
  get "/users/user_page", :as => "user_page"
  post "users/user_edit", :as => "user_edit"
  post "carts/remove_item", :as => "remove_item"
  post "carts/create_cart", :as => "create_cart"
  post "carts/order_submit", :as => "order_submit"
  post "carts/cart_process", :as => "cart_process"
  post "/login/authentication", :as => "authentication"
  post "/phones/search_results", :to => "phones#search_results", :as => "search_results"
  post "/phones/search_button", :as => "search_button"
  post "/carts/update_address", :as => "update_address"
  resources :carts, :only => [:create]
  resources :orders, :only => [:index, :create]
  resources :phones, :only => [:index, :show]
  resources :users, :only => [:new, :create, :update]



end
