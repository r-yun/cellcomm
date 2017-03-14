class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
    @phone = Phone.find(params[:phone_id])
    @review = Review.new(:phone_id => @phone.id)
  end

  def create
  end

  def delete
  end

  def destroy
  end
end
