class DssMessenger.Models.Recipient extends Backbone.Model
  paramRoot: 'recipient'

  defaults:
    uid: null

class DssMessenger.Collections.RecipientsCollection extends Backbone.Collection
  model: DssMessenger.Models.Recipient
  url: '/recipients'
