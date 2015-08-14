class DssMessenger.Models.Publishers extends Backbone.Model
  paramRoot: 'publisher'

  defaults:
    name: null

  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at', 'created_at')

class DssMessenger.Collections.PublishersCollection extends Backbone.Collection
  model: DssMessenger.Models.Publishers
  url: '/publishers'
