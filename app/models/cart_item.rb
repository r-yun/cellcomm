class CartItem < ApplicationRecord
  belongs_to :cart, {:optional => true}
  belongs_to :phone, {:optional => true}
end
