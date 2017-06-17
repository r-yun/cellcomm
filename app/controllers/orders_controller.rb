class OrdersController < ApplicationController
  before_action :user

  def index
  end

  def create
    @phones = Phone.all
    @user = User.find(session[:user_id])
    delivery_date = Time.now + 7.days
    order_number = (0..8).map{[*0..9, *"A".."Z"].sample}.join

    order = Order.create(:delivery_date => delivery_date, :order_number =>
    order_number, :user_id => @user)

    params_hash = params.slice(*[*"1"..@phones.length.to_s])
    params_hash.each do |k,v|
        order_item = OrderItem.create(:phone_id => k, :quantity_sold => v)
        order_item.order = order
        order_item.save
    end
    order.update_attributes(:delivery_date => delivery_date, :order_number =>
    order_number, :user_id => @user)
  end
end
