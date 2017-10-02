class Phone < ApplicationRecord
  has_one :order_item
  has_many :cart_items

  def self.search_algorithm(search)
    return if search.length <= 2
    query    = [(["phone_name LIKE ? OR brand_name LIKE ?"] * search.split.length).join(' OR ')]
    keywords = search.split.flat_map{|x|["%" + x + "%"] * 2}
    where(query + keywords)
  end

  def self.checkbox_search(params_hash)
    where(params_hash.slice("brand_name", "os", "price_category"))
  end


end
