Rails.application.routes.draw do

  root :to => "phones#index"
  get "/phones/search_results", :to => "phones#search_results", :as => "search_results1"
  get "/phones/s", :to => "phones#index" 
  post "/phones/search_results", :to => "phones#search_results", :as => "search_results"
  get "/phones/testing", :to => "phones#testing"
  post "/phones", :to => "phones#index"
  post "/phones/agnes", :to => "phones#agnes", :as  => "agnes"
  resources :phones, :only => [:index, :show]
  resources :reviews do
    member do
      get :delete
    end
  end


end
