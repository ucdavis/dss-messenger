DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.NewView extends Backbone.View
  template: JST["backbone/templates/messages/form"]

  events:
    "submit #message-form": "save"
    "focus #Recipients"	:	"tokenInput"
    "mouseenter .control-group"   : "tooltip"

  initialize: ->
    _.defer =>
      $("html, body").animate({ scrollTop: "0px" });
      # initialise recipients token input
      @tokenInput()
      # display loading gif while loading single and multi select inputs
      $("#classifications_select").html("<div class='loading'></div>")
      $("#modifiers_select").html("<div class='loading'></div>")
      $("#impacted_services_select").html("<div class='loading'></div>")
      # load the single and multi select inputs laoded originally from the router
      $("#classifications_select").empty()
      DssMessenger.classifications.each (classification) ->
        $("#classifications_select").append "<label class='radio'><input type='radio' name='classification_id[]' value='" + classification.get('id') + "'>" + classification.get('description') + "</label>"

      $("#modifiers_select").empty()
      DssMessenger.modifiers.each (modifier) ->
        $("#modifiers_select").append "<label class='radio'><input type='radio' name='modifier_id[]' value='" + modifier.get('id') + "'>" + modifier.get('description') + "</label>"

      $("#impacted_services_select").empty()
      DssMessenger.impacted_services.each (impacted_service) ->
        $("#impacted_services_select").append "<label class='checkbox'><input type='checkbox' name='impacted_service_ids[]' value='" + impacted_service.get('id') + "'>" + impacted_service.get('name') + "</label>"

    Backbone.Validation.bind this

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      $('p.error-message').remove()
      $('.error').removeClass('error')
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
    
  tooltip: (a) ->
    @$('#'+a.currentTarget.id).tooltip
      placement: "left"

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
    
    # Disable the submit button
    $('input[type="submit"]').val('Sending...').attr('disabled', 'disabled');

    @model.unset("errors")
    @model.set
      impacted_service_ids: _.map($("input[name='impacted_service_ids[]']:checked"), (a) -> a.value )
      classification_id: $("input[name='classification_id[]']:checked").val()
      modifier_id: $("input[name='modifier_id[]']:checked").val()
      window_start: $("input[name='window_start']").val()
      window_end: $("input[name='window_end']").val()

    @collection.create(@model.toJSON(),
      timeout: 30000
      wait: true
      at: 0
      success: (message) =>
        @model = message
        window.location.hash = "#/index"
        $("html, body").animate({ scrollTop: "0px" });

      error: (message, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
        unless jqXHR.status >= 200 and jqXHR.status < 300
          $("html, body").animate({ scrollTop: "0px" });
          $('input[type="submit"]').val('Try Sending Again').removeAttr('disabled').addClass('btn-danger');
    )

  render: ->
    @$el.html("<h1>New Message</h1>")
    @$el.append(@template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)

    _.defer =>
      @datetimePicker()
    
    return this
