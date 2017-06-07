class OrderItem < ApplicationRecord
  belongs_to :order, {:optional => true}
  belongs_to :phone, {:optional => true}
end
