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
        recipients.each (recipient) ->
          $("#new_recipients_select").append "<option value='" + recipient.get('id') + "'>" + recipient.get('uid') + "</option>"

      error: (recipients, response) ->
        console.log "#{response.status}."

    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch	

      success: (impacted_services) ->
        impacted_services.each (impacted_service) ->
          $("#impacted_services_select").append "<option value='" + impacted_service.get('id') + "'>" + impacted_service.get('name') + "</option>"

      error: (impacted_services, response) ->
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
