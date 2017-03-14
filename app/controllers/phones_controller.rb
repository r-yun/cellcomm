class PhonesController < ApplicationController
  def index
    @brand_names = Phone.select(:brand_name).distinct.order(:brand_name)
    @operating_systems = Phone.select(:os).distinct

 # ANDbrand_phone need unique
  end

  def search_results
    respond_to do |format|
      format.html {render(:partial => "phones/search_results.html.erb")}
      format.js {render("search_results.js.erb")}
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
