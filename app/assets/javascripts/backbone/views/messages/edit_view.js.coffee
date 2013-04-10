DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.EditView extends Backbone.View
  template: JST["backbone/templates/messages/edit"]

  events:
    "submit #edit-message": "update"
    "focus .datepicker"	:	"displayPicker"

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


  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (message) =>
        @model = message
        window.location.hash = "#/index"
    )

  displayPicker: (e) ->
    $('.datepicker').datetimepicker()


  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
