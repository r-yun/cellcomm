Rails.application.routes.draw do

  root :to => "phones#index"
  get "carts/cart", :as => "cart_page"
  get "carts/checkout", :as => "checkout"
  get "login/logout", :as => "logout"
  get "login/login_page", :as => "login_page"
  get "users/user_page", :as => "user_page"
  post "users/user_edit", :as => "user_edit"
  post "carts/cart_process", :as => "cart_process"
  post "carts/create_cart", :as => "create_cart"
  post "carts/order_submit", :as => "order_submit"
  post "carts/remove_item", :as => "remove_item"
  post "carts/update_price", :as => "update_price"
  post "carts/update_address", :as => "update_address"
  post "carts/calculate_totals", :as => "calculate_totals"
  post "login/authentication", :as => "authentication"
  post "phones/search_results", :as => "search_results"
  resources :carts, :only => [:create]
  resources :phones, :only => [:index, :show]
  resources :users, :only => [:new, :create]



end
