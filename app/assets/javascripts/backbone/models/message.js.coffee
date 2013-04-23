class DssMessenger.Models.Message extends Backbone.Model
  paramRoot: 'message'

  defaults:
    subject: null
    impact_statement: null
    window_start: null
    window_end: null
    purpose: null
    resolution: null
    workaround: null
    other_services: null
    sender_uid: null
    recipient_ids: null
    impacted_service_ids: null
    messenger_event_ids: null

  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at')
    json



class DssMessenger.Collections.MessagesCollection extends Backbone.Collection
  model: DssMessenger.Models.Message
  url: '/messages'
