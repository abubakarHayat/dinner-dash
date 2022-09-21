json.array! @orders_all do |order|
  json.id order.id
  json.user order.user
  json.total order.total
  json.status order.status
end
