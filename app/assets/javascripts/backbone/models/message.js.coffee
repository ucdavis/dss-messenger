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

  initialize: ->
    @recipients = new DssMessenger.Collections.RecipientsCollection(@get("recipient_ids"))
  
  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at','created_at','recipients','impacted_services','messenger_events')
    console.log "toJSON"
    console.log json
    json

  toFullJSON: () ->
    json = _.omit(this.attributes, 'updated_at')
    console.log "toFullJSON"
    console.log json
    json

class DssMessenger.Collections.MessagesCollection extends Backbone.Collection
  model: DssMessenger.Models.Message
  url: '/messages'
