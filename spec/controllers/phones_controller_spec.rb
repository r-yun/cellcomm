require 'rails_helper'

RSpec.describe PhonesController, type: :controller do
  describe "search_results (POST)" do
    before(:context){ load("db/seeds.rb") }
    after(:context){ Phone.destroy_all}

    it "returns the appropriate search results if the 'all' checkbox is selected" do
      post :search_results, :params => {"all" => "true"}
      @search_results = Phone.order(:brand_name)
      expect(assigns(:phones)).to eq(@search_results)
    end

    it "returns the appropriate search results if a brand checkbox is selected" do
      post :search_results, :params => {"brand_name" => "Samsung"}
      @search_results = Phone.checkbox_search("brand_name" => "Samsung")
      expect(assigns(:phones)).to eq(@search_results)
    end

    it "returns the appropriate search results if the user types a term in the search box" do
      post :search_results, :params => {"search_field" => "blackberry"}
      @search_results = Phone.search_algorithm("blackberry")
      expect(assigns(:phones)).to eq(@search_results)
    end
  end
end
