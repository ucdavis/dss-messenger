DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.NewView extends Backbone.View
  template: JST["backbone/templates/messages/new"]

  events:
    "submit #new-message": "save"
    "focus .datepicker"	 : "displayPicker"

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

    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.fetch	

      success: (messenger_events) ->
        messenger_events.each (messenger_event) ->
          $("#messenger_events_select").append "<option value='" + messenger_event.get('id') + "'>" + messenger_event.get('description') + "</option>"

      error: (messenger_events, response) ->
        console.log "#{response.status}."


  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  displayPicker: (e) ->
    $('.datepicker').datetimepicker()


  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    @model.set
      recipient_ids: _.map($("#new_recipients_select").val(), (a) -> a )
      impacted_service_ids: _.map($("#impacted_services_select").val(), (a) -> a )
      messenger_event_ids: _.map($("#messenger_events_select").val(), (a) -> a )

    @collection.create(@model.toJSON(),
      success: (message) =>
        @model = message
        window.location.hash = "#/index"

      error: (message, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
