module Relationships

  def get_items(id_in)
    items_array = []
    list_of_items = Item.list_of_items
    list_of_items.each do |item|
      if item.merchant_id == id_in
        items_array.push(item)
      end
    end
    # item_hash = {id: "1", name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: "75107", merchant_id: "1", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC"}
    # item_array = [Item.new(item_hash)]
    return items_array
  end
end
