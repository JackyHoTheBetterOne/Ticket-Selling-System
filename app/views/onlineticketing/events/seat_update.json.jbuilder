json.seats @seats do |seat|
  json.name seat.name
  json.status seat.aasm_state
  json.price seat.price_group.price
end