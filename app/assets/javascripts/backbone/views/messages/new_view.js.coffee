DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.NewView extends Backbone.View
  template: JST["backbone/templates/messages/new"]

  events:
    "submit #new-message": "save"
    "focus #Recipients"	:	"tokenInput"

  initialize: ->
    _.defer =>
      $("html, body").animate({ scrollTop: "0px" });
      # initialise recipients token input
      @tokenInput()
      # display loading gif while loading single and multi select inputs
      $("#classifications_select").html("<div class='loading'></div>")
      $("#modifiers_select").html("<div class='loading'></div>")
      $("#impacted_services_select").html("<div class='loading'></div>")
      $("#messenger_events_select").html("<div class='loading'></div>")
      # load the single and multi select inputs laoded originally from the router
      $("#classifications_select").empty()
      DssMessenger.classifications.each (classification) ->
        console.log classification.get('id');
        $("#classifications_select").append "<label class='radio'><input type='radio' name='classification_id[]' value='" + classification.get('id') + "'>" + classification.get('description') + "</label>"

      $("#modifiers_select").empty()
      DssMessenger.modifiers.each (modifier) ->
        $("#modifiers_select").append "<label class='radio'><input type='radio' name='modifier_id[]' value='" + modifier.get('id') + "'>" + modifier.get('description') + "</label>"

      $("#impacted_services_select").empty()
      DssMessenger.impacted_services.each (impacted_service) ->
        $("#impacted_services_select").append "<label class='checkbox'><input type='checkbox' name='impacted_service_ids[]' value='" + impacted_service.get('id') + "'>" + impacted_service.get('name') + "</label>"

      $("#messenger_events_select").empty()
      DssMessenger.messenger_events.each (messenger_event) ->
        $("#messenger_events_select").append "<label class='checkbox'><input type='checkbox' name='messenger_event_ids[]' value='" + messenger_event.get('id') + (if messenger_event.get('id') == 1 then "' checked />" else "' />") + messenger_event.get('description') + "</label>"

    Backbone.Validation.bind this

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      _.each @model.get('errors'), (error,index) ->
        $('#'+index).closest('.control-group').addClass('error')
        $('#'+index).closest('.control-group .controls').append('<p class="help-block error-message">' + error + '</p>')
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
      wait: true
      at: 0
      success: (message) =>
        @model = message
        window.location.hash = "#/index"
        $("html, body").animate({ scrollTop: "0px" });

      error: (message, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)

    _.defer =>
      @datetimePicker()
    
    return this
