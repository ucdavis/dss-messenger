# The tokenfield-typeahead plugin assumes a JSON array containing 'id' and 'value'
json.array! @recipients do |recipient|
  json.value recipient.id
  json.label recipient.name
end
