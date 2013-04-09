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
    recipients_list: null

  toJSON: () ->
    _.omit(this.attributes, 'updated_at')

  initialize: ->
    @recipients = new DssMessenger.Collections.RecipientsCollection()
    @recipients.fetch	

      success: (recipients) ->
        recipients_list = ""
        recipients.each (recipient) ->
          recipients_list = recipients_list + "<option value='" + recipient.get('uid') + "'>" + recipient.get('uid') + "</option>"
          $("#new_recipients_select").append recipients_list

      error: (recipients, response) ->
        console.log "#{response.status}."
	

class DssMessenger.Collections.MessagesCollection extends Backbone.Collection
  model: DssMessenger.Models.Message
  url: '/messages'
