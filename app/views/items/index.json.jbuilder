json.array! @items do |item|
  json.id item.id
  json.title item.item_title
  json.description item.item_description
  json.price item.item_price
  if item.image.attached?
    json.image "http://localhost:3001#{url_for(item.image)}"
  else
    json.image ''
  end
  json.restaurant item.restaurant
end
