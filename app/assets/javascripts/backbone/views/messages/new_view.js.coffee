DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.NewView extends Backbone.View
  template: JST["backbone/templates/messages/new"]

  events:
    "submit #new-message": "save"
    "focus .datepicker"	 : "displayPicker"
    "focus #Recipients"	:	"tokenInput"

  initialize: ->
    $("input[name=Recipients]").tokenInput "http://shell.loopj.com/tokeninput/tvshows.php",
      theme: "facebook" #WHY NO SHOW!
    @recipients = new DssMessenger.Collections.RecipientsCollection()
    @recipients.fetch	

      success: (recipients) ->
        recipients.each (recipient) ->
          $("#new_recipients_select").append "<input type='checkbox' name='recipient_ids[]' value='" + recipient.get('id') + "' /> " + recipient.get('uid') + "<br />"

      error: (recipients, response) ->
        console.log "#{response.status}."

    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch	

      success: (impacted_services) ->
        impacted_services.each (impacted_service) ->
          $("#impacted_services_select").append "<input type='checkbox' name='impacted_service_ids[]' value='" + impacted_service.get('id') + "'>" + impacted_service.get('name') + "<br />"

      error: (impacted_services, response) ->
        console.log "#{response.status}."

    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.fetch	

      success: (messenger_events) ->
        messenger_events.each (messenger_event) ->
          $("#messenger_events_select").append "<input type='checkbox' name='messenger_event_ids[]' value='" + messenger_event.get('id') + "'>" + messenger_event.get('description') + "<br />"

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

  tokenInput: (e) ->
    $("input[name=recipient_ids]").tokenInput "/recipients",
      theme: "facebook"
      onAdd: (item) =>
        console.log @model

      onDelete: (item) =>
        console.log @model
    
  save: (e) ->
    e.preventDefault()
    e.stopPropagation()


    @model.unset("errors")
    @model.set
      impacted_service_ids: _.map($("input[name='impacted_service_ids[]']:checked"), (a) -> a.value )
      messenger_event_ids: _.map($("input[name='messenger_event_ids[]']:checked"), (a) -> a.value )

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
