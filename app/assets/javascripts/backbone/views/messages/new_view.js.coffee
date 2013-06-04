DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.NewView extends Backbone.View
  template: JST["backbone/templates/messages/new"]

  events:
    "submit #new-message": "save"
    "focus #Recipients"	:	"tokenInput"

  initialize: ->
    _.defer =>
      @tokenInput()

    @classifications = new DssMessenger.Collections.ClassificationsCollection()
    @classifications.fetch	

      success: (classifications) ->
        classifications.each (classification) ->
          $("#classifications_select").append "<label class='radio'><input type='radio' name='classification_id[]' value='" + classification.get('id') + "'>" + classification.get('description') + "</label>"

      error: (classifications, response) ->
        console.log "#{response.status}."

    @modifiers = new DssMessenger.Collections.ModifiersCollection()
    @modifiers.fetch	

      success: (modifiers) ->
        modifiers.each (modifier) ->
          $("#modifiers_select").append "<label class='radio'><input type='radio' name='modifier_id[]' value='" + modifier.get('id') + "'>" + modifier.get('description') + "</label>"

      error: (modifiers, response) ->
        console.log "#{response.status}."

    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch	

      success: (impacted_services) ->
        impacted_services.each (impacted_service) ->
          $("#impacted_services_select").append "<label class='checkbox'><input type='checkbox' name='impacted_service_ids[]' value='" + impacted_service.get('id') + "'>" + impacted_service.get('name') + "</label>"

      error: (impacted_services, response) ->
        console.log "#{response.status}."

    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.fetch	

      success: (messenger_events) ->
        messenger_events.each (messenger_event) ->
          $("#messenger_events_select").append "<label class='checkbox'><input type='checkbox' name='messenger_event_ids[]' value='" + messenger_event.get('id') + "'>" + messenger_event.get('description') + "</label>"

      error: (messenger_events, response) ->
        console.log "#{response.status}."


  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  datetimePicker: ->
    $('.datetimepicker').datetimepicker
      language: "en"
      pick12HourFormat: true
      pickSeconds: false

  tokenInput: (e) ->
    $("input[name=recipient_uids]").tokenInput "/recipients",
      theme: "facebook"
      onAdd: (item) =>
        #console.log @model

      onDelete: (item) =>
        #console.log @model
    
  save: (e) ->
    e.preventDefault()
    e.stopPropagation()


    @model.unset("errors")
    @model.set
      impacted_service_ids: _.map($("input[name='impacted_service_ids[]']:checked"), (a) -> a.value )
      messenger_event_ids: _.map($("input[name='messenger_event_ids[]']:checked"), (a) -> a.value )
      classification_id: $("input[name='classification_id[]']:checked").val()
      modifier_id: $("input[name='modifier_id[]']:checked").val()
      window_start: $("input[name='window_start']").val()
      window_end: $("input[name='window_end']").val()

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

    _.defer =>
      @datetimePicker()
    
    return this
