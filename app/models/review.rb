class Review < ApplicationRecord
  belongs_to :phone, {:optional => true}
  belongs_to :user, {:optional => true}
end
