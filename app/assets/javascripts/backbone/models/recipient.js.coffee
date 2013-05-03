class DssMessenger.Models.Recipient extends Backbone.Model
  paramRoot: 'recipient'

  defaults:
    uid: null

  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at', 'created_at')

class DssMessenger.Collections.RecipientsCollection extends Backbone.Collection
  model: DssMessenger.Models.Recipient
  url: '/recipients'
