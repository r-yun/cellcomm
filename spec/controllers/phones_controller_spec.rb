require 'rails_helper'

RSpec.describe PhonesController, type: :controller do
  describe "GET index" do
    before(:example) { get :index }
    context "index testing" do
      it "returns an http status of ok" do
        expect(response).to have_http_status(:ok)
      end

      it "renders the 'index' template" do
        expect(response).to render_template("index")
      end
   end

    context "partial testing" do
      render_views
      before(:example) { get :index }
      it "renders '_checkbox_form.html.erb'" do
         expect(response).to render_template(:partial => "_checkbox_form.html.erb")
      end

      it "renders '_search_results.html.erb'" do
        expect(response).to render_template(:partial => "_search_results.html.erb")
      end

      end # context
  end # describe


  describe "POST search_results" do

    it "returns the params[:all] method" do
      post :search_results, params: {"all" => "true"}
      @test = Phone.all.order(:brand_name)
      expect(assigns(:phones)).to eq(@test)
    end

    it "returns the params[:brand_name] method" do
      post :search_results, params: {"brand_name" => "Samsung"}
      @test = Phone.checkbox_search("brand_name" => "Samsung")
      expect(assigns(:phones)).to eq(@test)
    end

    it "returns the params[:search_field] method" do
      post :search_results, params: {"search_field" => "blackberry"}
      @test = Phone.search_algorithm("blackberry")
      expect(assigns(:phones)).to eq(@test)
    end
  end # describe
end # Rspec.describe
