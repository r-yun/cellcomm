class PhonesController < ApplicationController
  def index
    @brand_name = Phone.new
    @brand_names = Phone.select(:brand_name).distinct.order(:brand_name)
    @operating_systems = Phone.select(:os).distinct
    @price_categories = Phone.select(:price_category).distinct.order(price_category: :asc)
 # ANDbrand_phone need unique
  end

  def search_results
    respond_to do |format|
      format.html {render :partial => "search_results.html.erb"}
      format.js {render("search_results.js.erb")
      }
    end
  end

  def agnes
    @thing = Phone.all
    render(:layout => false)#, :locals => {:phones => @thing})
  end

  def testing
  end
  # end
  def show
    @phone = Phone.find(params[:id])
  end
end
