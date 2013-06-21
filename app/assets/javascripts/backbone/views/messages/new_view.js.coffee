DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.NewView extends Backbone.View
  template: JST["backbone/templates/messages/new"]

  events:
    "submit #new-message": "save"
    "focus #Recipients"	:	"tokenInput"

  initialize: ->
    _.defer =>
      @tokenInput()
      $("#classifications_select").html("<div class='loading'></div>")
      $("#modifiers_select").html("<div class='loading'></div>")
      $("#impacted_services_select").html("<div class='loading'></div>")
      $("#messenger_events_select").html("<div class='loading'></div>")

    @classifications = new DssMessenger.Collections.ClassificationsCollection()
    @classifications.fetch	

      success: (classifications) ->
        $("#classifications_select").empty()
        classifications.each (classification) ->
          $("#classifications_select").append "<label class='radio'><input type='radio' name='classification_id[]' value='" + classification.get('id') + "'>" + classification.get('description') + "</label>"

      error: (classifications, response) ->
        $("#classifications_select").html("<div class='error'></div>")
        console.log "#{response.status}."

    @modifiers = new DssMessenger.Collections.ModifiersCollection()
    @modifiers.fetch	

      success: (modifiers) ->
        $("#modifiers_select").empty()
        modifiers.each (modifier) ->
          $("#modifiers_select").append "<label class='radio'><input type='radio' name='modifier_id[]' value='" + modifier.get('id') + "'>" + modifier.get('description') + "</label>"

      error: (modifiers, response) ->
        $("#modifiers_select").html("<div class='error'></div>")
        console.log "#{response.status}."

    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch

      success: (impacted_services) ->
        $("#impacted_services_select").empty()
        impacted_services.each (impacted_service) ->
          $("#impacted_services_select").append "<label class='checkbox'><input type='checkbox' name='impacted_service_ids[]' value='" + impacted_service.get('id') + "'>" + impacted_service.get('name') + "</label>"

      error: (impacted_services, response) ->
        $("#impacted_services_select").html("<div class='error'></div>")
        console.log "#{response.status}."

    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.fetch	

      success: (messenger_events) ->
        $("#messenger_events_select").empty()
        messenger_events.each (messenger_event) ->
          $("#messenger_events_select").append "<label class='checkbox'><input type='checkbox' name='messenger_event_ids[]' value='" + messenger_event.get('id') + (if messenger_event.get('id') == 1 then "' checked />" else "' />") + messenger_event.get('description') + "</label>"

      error: (messenger_events, response) ->
        $("#messenger_events_select").html("<div class='error'></div>")
        console.log "#{response.status}."

    Backbone.Validation.bind this

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  datetimePicker: ->
    $('.datetimepicker').datetimepicker
      format: "yyyy/mm/dd HH:ii P"
      minuteStep: 30
      # minView: 2 (this + an interactive format could be used to have only dates)
      autoclose: true
      todayBtn: true
      todayHighlight: true
      showMeridian: true
      pickerPosition: "bottom-left"
    

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
      at: 0
      success: (message) =>
        @model = message
        window.location.hash = "#/index"
        window.scrollTo 0, 0

      error: (message, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)

    _.defer =>
      @datetimePicker()
    
    return this
