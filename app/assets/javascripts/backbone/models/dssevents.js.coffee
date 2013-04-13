class DssMessenger.Models.Dssevents extends Backbone.Model
  paramRoot: 'event'

  defaults:
    description: null

class DssMessenger.Collections.DsseventsCollection extends Backbone.Collection
  model: DssMessenger.Models.Dssevents
  url: '/events'
