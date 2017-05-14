Rails.application.routes.draw do

  root :to => "phones#index"
  get "/phones/test"
  post "/phones/search_results", :to => "phones#search_results", :as => "search_results"
  resources :phones, :only => [:index, :show]
  resources :reviews do
    member do
      get :delete
    end
  end


end
