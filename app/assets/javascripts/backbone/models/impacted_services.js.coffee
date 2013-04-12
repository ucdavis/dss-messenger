class DssMessenger.Models.impacted_services extends Backbone.Model
  paramRoot: 'impacted_service'

  defaults:
    name: null

class DssMessenger.Collections.impacted_servicesCollection extends Backbone.Collection
  model: DssMessenger.Models.impacted_services
  url: '/impacted_services'
