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
    closed: false

  validation:
    recipient_uids:
      required: true
      msg: "Please enter at least one recipient"
    subject:
      required: true
      msg: "Please enter message subject"
    impact_statement:
      required: true
      msg: "Please enter an impact statement"
    publisher_ids:
      required: true
      msg: "Please use at least one publisher"

  toJSON: () ->
    json = _.omit(this.attributes, 'updated_at','created_at','classification','modifier','recipients','impacted_services','pages','current','sender_name', 'created_at_in_words', 'recipient_counts', 'send_status', 'channel_ids[]', 'publishers')
    json

  toFullJSON: () ->
    json = _.omit(this.attributes, 'updated_at')
    json

  # Similar to toFullJSON but preserves text area formatting by converting certain
  # aspects to HTML
  toPreviewJSON: () ->
    json = _.omit(this.attributes, 'updated_at')
    json.impact_statement = this.preserveFormattingAsHTML(json.impact_statement)
    json.purpose = this.preserveFormattingAsHTML(json.purpose)
    json.resolution = this.preserveFormattingAsHTML(json.resolution)
    json.workaround = this.preserveFormattingAsHTML(json.workaround)
    json.other_services = this.preserveFormattingAsHTML(json.other_services)
    json

  preserveFormattingAsHTML: (str) ->
    return String(str)
            .replace(/&/g, '&amp;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/\r?\n/g, '<br/>') # line breaks
            .replace(/\s/g, '&nbsp;')   # whitespace

class DssMessenger.Collections.MessagesCollection extends Backbone.Collection
  model: DssMessenger.Models.Message
  url: '/messages'
