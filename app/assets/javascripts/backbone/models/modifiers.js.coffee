class DssMessenger.Models.Modifiers extends Backbone.Model
  paramRoot: 'modifier'

  defaults:
    description: null

  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at', 'created_at')


class DssMessenger.Collections.ModifiersCollection extends Backbone.Collection
  model: DssMessenger.Models.Modifiers
  url: '/modifiers'
