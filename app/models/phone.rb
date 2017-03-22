class Phone < ApplicationRecord
  has_many :reviews
  scope :search_algorithm, ->(search) do
    #if search = 2 words and 2nd word = number, then treat as one word
    #IF 3 LETTERS+ NOT A WORD --> RETURN NOTHING

    where([(["phone_name LIKE ? OR brand_name LIKE ?"] * search.split.length).join(' OR ')] +
    search.split.flat_map{|x|["%" + x + "%"]*2})
  end

  def self.checkbox_search(params_hash)

    params_array = [:brand_name, :os, :price_category]
    column_array = []
    key_array = []
    params_hash.each do |k,v|
      if params_array.include?(k)
         column_array << v
         key_array << k
         puts column_array + key_array
      end
    end
  return  joined_keys = key_array.join(" in (?) AND ") + ", " + "#{column_array}"
  end

end
