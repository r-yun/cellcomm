class PhonesController < ApplicationController
  def index
    @brand_names = Phone.select(:brand_name).distinct.order(:brand_name)
    @operating_systems = Phone.select(:os).distinct
    @price_categories = Phone.select(:price_category).distinct.order(price_category: :asc)
    @phones = Phone.all.order(:brand_name)
  end

  def search_results
    #If the all checkbox checked.
    if params[:all].present?
      @phones = Phone.all.order(:brand_name)
    #If any checkbox besides all got checked.
    elsif params[:brand_name].present?|| params[:os].present? || params[:price_category].present?
      @phones = Phone.checkbox_search(request.POST)
    #If searchbox form submitted.
    elsif params[:search].present?
      @phones = Phone.search_algorithm(params[:search])
    end

    respond_to do |format|
    format.html{ render "index.html.erb"}  
    format.js { render "search_results.js.erb"}
  end

  end


  def show
    @phone = Phone.find(params[:id])
  end
end
