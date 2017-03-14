class Phone < ApplicationRecord
  has_many :reviews
  scope :search_algorithm, ->(search) do
    #if search = 2 words and 2nd word = number, then treat as one word
    #IF 3 LETTERS+ NOT A WORD --> RETURN NOTHING

    where([(["phone_name LIKE ? OR brand_name LIKE ?"] * search.split.length).join(' OR ')] +
    search.split.flat_map{|x|["%" + x + "%"]*2})
  end

end
