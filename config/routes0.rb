Rails.application.routes.draw do

  root :to => "phones#index"
  get "/phones/search_results", :to => "phones#search_results", :as => "search_results"
  post "/phones", :to => "phones#index"
  resources :phones, :only => [:index, :show]
  resources :reviews do
    member do
      get :delete
    end
  end


end
