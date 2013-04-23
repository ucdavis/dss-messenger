DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.EditView extends Backbone.View
  template: JST["backbone/templates/messages/edit"]

  events:
    "submit #edit-message": "update"
    "focus .datepicker"	:	"displayPicker"

  initialize: ->
    @current_recipients = @model.get('recipients')
    @recipients = new DssMessenger.Collections.RecipientsCollection()
    @recipients.fetch	

      success: (recipients) =>
        recipients.each (recipient) =>
          @checked = _.find @current_recipients, (current_recipient) =>
            return current_recipient.id is recipient.get('id')
          if @checked
            $("#new_recipients_select").append "<input type='checkbox' name='recipient_ids' value='" + recipient.get('id') + "' checked>" + recipient.get('uid') + "<br \>"
          else
            $("#new_recipients_select").append "<input type='checkbox' name='recipient_ids' value='" + recipient.get('id') + "'>" + recipient.get('uid') + "<br \>"
            

      error: (recipients, response) ->
        console.log "#{response.status}."
        #TODO: display error on screen

    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch	

      success: (impacted_services) ->
        impacted_services.each (impacted_service) ->
          $("#impacted_services_select").append "<option value='" + impacted_service.get('id') + "'>" + impacted_service.get('name') + "</option>"

      error: (impacted_services, response) ->
        console.log "#{response.status}."

    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.fetch	

      success: (messenger_events) ->
        messenger_events.each (messenger_event) ->
          $("#messenger_events_select").append "<option value='" + messenger_event.get('id') + "'>" + messenger_event.get('description') + "</option>"

      error: (messenger_events, response) ->
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
