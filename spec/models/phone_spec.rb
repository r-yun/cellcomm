require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe "search box algorithm" do
    context "Search query is 2 characters or less" do

      it "does not return any objects" do
       Phone.create([{:brand_name => "Blackberry"}, {:brand_name => "Google"}])
        @test = Phone.search_algorithm("bl")
        #why does return nil?
        expect(@test.nil?).to eq(true)
      end
    end

    context "search query is 1 word (more than 2 characters)" do

      it "returns brand name of query" do
        Phone.create([{:brand_name => "Blackberry"}, {:brand_name => "Google"}])
        @test = Phone.search_algorithm("Blackberry")
        expect(@test.count).to eq(1)
        expect(@test.first).to have_attributes(:brand_name => "Blackberry")
      end
    end


    context "search query is 2 words (combined more than 2 characters)" do

      it "returns two separate brands when the query is two brands" do
        Phone.create([{:brand_name => "Blackberry"}, {:brand_name => "Google"}])
        @test = Phone.search_algorithm("Blackberry Google")
        expect(@test.count).to eq(2)
        expect(@test.find_by_brand_name(:Blackberry)).to have_attributes(:brand_name => "Blackberry")
        expect(@test.find_by_brand_name(:Google)).to have_attributes(:brand_name => "Google")
      end

      it "returns a phone and a brand when the query has a phone and a brand in it" do
        Phone.create([{:brand_name => "Blackberry", :phone_name => "Priv"}, {:brand_name => "Google", :phone_name => "Pixel"}])
        @test = Phone.search_algorithm("Blackberry Pixel")
        expect(@test.count).to eq(2)
        expect(@test.find_by_brand_name(:Blackberry)).to have_attributes(:brand_name => "Blackberry")
        expect(@test.find_by_brand_name(:Google)).to have_attributes(:phone_name => "Pixel")
      end # it
    end # context
  end # describe

  describe "checkbox search algorithm" do

    it "returns back appropriate object from params hash" do
      Phone.create(
      [{:brand_name => "Blackberry", :phone_name => "Classic", :os => "Blackberry", :price_category => 1},
      {:brand_name => "Blackberry", :phone_name => "Priv", :os => "Blackberry", :price_category => 3},
      {:brand_name => "Google", :phone_name => "Pixel", :os => "Android", :price_category => 3}])
      params_hash = {"brand_name" => "Blackberry", "os" => "Blackberry", "price_category" => 1}
      @test = Phone.checkbox_search(params_hash)
      expect(@test.count).to eq(1)
      expect(@test.find_by_brand_name(:Blackberry)).to have_attributes(
      :brand_name => "Blackberry", :phone_name => "Classic")
    end # it
  end # describe
end # Rspec.describe
