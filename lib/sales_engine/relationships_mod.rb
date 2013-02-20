module SalesEngine
  module Relationships
    def get_items(id_in)
      items_array = []
      list_of_items = Item.list_of_items
      list_of_items.each do |item|
        if item.merchant_id == id_in
          items_array.push(item)
        end
      end
      return items_array
    end
  end
end
