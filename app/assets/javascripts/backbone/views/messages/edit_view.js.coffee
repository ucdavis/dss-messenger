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
          $("#new_recipients_select").append "<input type='checkbox' name='recipient_ids[]' value='" + recipient.get('id') + (if @checked then "' checked />" else "' />") + recipient.get('uid') + "<br />"

      error: (recipients, response) ->
        console.log "#{response.status}."
        #TODO: display error on screen

    @current_services = @model.get('impacted_services')
    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch	

      success: (impacted_services) =>
        impacted_services.each (impacted_service) =>
          @checked = _.find @current_services, (current_service) =>
            return current_service.id is impacted_service.get('id')
          $("#impacted_services_select").append "<input type='checkbox' name='impacted_service_ids[]' value='" + impacted_service.get('id') + (if @checked then "' checked />" else "' />") + impacted_service.get('name') + "<br />"

      error: (impacted_services, response) ->
        console.log "#{response.status}."

    @current_events = @model.get('messenger_events')
    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.fetch	

      success: (messenger_events) =>
        messenger_events.each (messenger_event) =>
          @checked = _.find @current_events, (current_event) =>
            return current_event.id is messenger_event.get('id')
          $("#messenger_events_select").append "<input type='checkbox' name='messenger_event_ids[]' value='" + messenger_event.get('id') + (if @checked then "' checked />" else "' />") + messenger_event.get('description') + "<br />"

      error: (messenger_events, response) ->
        console.log "#{response.status}."


  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.set
      #recipient_ids: _.map($("input[name='recipient_ids[]']:checked"), (a) -> a.value )
      #impacted_service_ids: _.map($("input[name='impacted_service_ids[]']:checked"), (a) -> a.value )
      #messenger_event_ids: _.map($("input[name='messenger_event_ids[]']:checked"), (a) -> a.value )
    
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
