class DssMessenger.Models.Classifications extends Backbone.Model
  paramRoot: 'classification'

  defaults:
    description: null

  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at', 'created_at')

class DssMessenger.Collections.ClassificationsCollection extends Backbone.Collection
  model: DssMessenger.Models.Classifications
  url: '/classifications'
