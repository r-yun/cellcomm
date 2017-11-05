class PhonesController < ApplicationController
  before_action :user

  def index
    @brand_names = Phone.select(:brand_name).distinct.order(:brand_name)
    @operating_systems = Phone.select(:os).distinct
    @price_categories = Phone.select(:price_category).distinct
      .order(price_category: :asc)
    if params[:search_field]
      @phones = Phone.search_algorithm(params[:search_field])
    else
      @phones = Phone.order(:brand_name)
    end
  end

  def test


  end

  def search_results
    if params[:all].present?
      @phones = Phone.order(:brand_name)
    elsif params[:brand_name].present?|| params[:os].present? ||
    params[:price_category].present?
      @phones = Phone.checkbox_search(request.POST)
    elsif params[:search_field].present?
      @phones = Phone.search_algorithm(params[:search_field])
    end
    redirect_to(phones_path(search_field: params[:search_field])) unless params[:executing_action] == "index"
  end

  def show
    @phone = Phone.find(params[:id])
  end

end
