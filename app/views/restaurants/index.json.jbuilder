json.array! @restaurants do |rest|
  json.id rest.id
  json.restaurant rest.restaurant_name
end
