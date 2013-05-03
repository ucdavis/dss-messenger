class DssMessenger.Models.messenger_events extends Backbone.Model
  paramRoot: 'messenger_event'

  defaults:
    description: null

  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at', 'created_at')

class DssMessenger.Collections.messenger_eventsCollection extends Backbone.Collection
  model: DssMessenger.Models.messenger_events
  url: '/messenger_events'
