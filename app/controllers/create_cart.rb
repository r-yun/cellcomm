

@phone = Phone.find(params[:phone_id])
puts @user.cart
#if @phone.quantity == 0 do not run

unless @phone.quantity == 0
if @user.cart.phones.include?(@phone)
else
  @user.cart.phones << @phone
  @user.save
end
session["phone_" + params[:phone_id]] =  params[:quantity]
puts session["phone_" + params[:phone_id]]

# put in key value hash :1 => "apple iphone" and iterate through hash putting quantities in respective
#update_attribute. check first before updating

# if phone_id matches session key then put value in view code
#cart.phones.each do |x|
#print based on that
