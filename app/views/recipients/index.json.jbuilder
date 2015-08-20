# The tokenfield-typeahead plugin assumes a JSON array containing 'id' and 'value'
json.array! @recipients do |recipient|
  json.id recipient.id
  json.value recipient.name
end
