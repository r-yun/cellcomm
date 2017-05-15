Rails.application.routes.draw do

  root :to => "phones#index"
  get "/login/login_page", :as => "login_page"
  get "/phones/login_page"
  post "/phones/search_results", :to => "phones#search_results", :as => "search_results"
  post "/phones/search_button", :as => "search_button"
  resources :phones, :only => [:index, :show]



end
