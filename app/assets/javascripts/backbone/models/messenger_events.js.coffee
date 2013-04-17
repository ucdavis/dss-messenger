class DssMessenger.Models.messenger_events extends Backbone.Model
  paramRoot: 'messenger_event'

  defaults:
    description: null

class DssMessenger.Collections.messenger_eventsCollection extends Backbone.Collection
  model: DssMessenger.Models.messenger_events
  url: '/messenger_events'
