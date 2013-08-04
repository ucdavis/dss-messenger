DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.DuplicateView extends Backbone.View
  template: JST["backbone/templates/messages/form"]
  preview: JST["backbone/templates/messages/form"]

  events:
    "submit #message-form": "save"
    "focus #Recipients"	:	"tokenInput"
    "mouseenter .control-group"   : "tooltip"
    "click .message-preview"  : "preview"

  initialize: ->
    Backbone.Validation.bind this

    _.defer =>
      @current_classification = @model.get('classification_id')
      @current_modifier = @model.get('modifier_id')
      @current_services = @model.get('impacted_services')

      $("html, body").animate({ scrollTop: "0px" });
      # initialise recipients token input and load duplicated recipients
      @tokenInput()
      recipients_tokeninput = @$("input[name=recipient_uids]")
      recipients_tokeninput.tokenInput "clear"
      _.each @model.get("recipients"), (recipient) ->
        recipients_tokeninput.tokenInput "add",
        id: recipient.uid
        name: recipient.name
      # load the single and multi select inputs laoded originally from the router
      $("#classifications_select").empty()
      DssMessenger.classifications.each (classification) =>
        @checked = @current_classification is classification.get('id')
        $("#classifications_select").append "<label class='radio'><input type='radio' name='classification_id[]' value='" + classification.get('id') + (if @checked then "' checked />" else "' />") + classification.get('description') + "</label>"

      $("#modifiers_select").empty()
      DssMessenger.modifiers.each (modifier) =>
        @checked = @current_modifier is modifier.get('id')
        $("#modifiers_select").append "<label class='radio'><input type='radio' name='modifier_id[]' value='" + modifier.get('id') + (if @checked then "' checked />" else "' />") + modifier.get('description') + "</label>"

      $("#impacted_services_select").empty()
      DssMessenger.impacted_services.each (impacted_service) =>
        @checked = _.find @current_services, (current_service) =>
          return current_service.id is impacted_service.get('id')
        $("#impacted_services_select").append "<label class='checkbox'><input type='checkbox' name='impacted_service_ids[]' value='" + impacted_service.get('id') + (if @checked then "' checked />" else "' />") + impacted_service.get('name') + "</label>"

    
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

    @collection.create(@model.toJSON(),
      timeout: 30000
      wait: true
      at: 0
      success: (message) =>
        @model = message
        
        #close the original message
        @original.save(closed:true)
        
        window.location.hash = "#/index"
        $("html, body").animate({ scrollTop: "0px" });

      error: (message, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
        unless jqXHR.status >= 200 and jqXHR.status < 300
          $("html, body").animate({ scrollTop: "0px" });
          $('input[type="submit"]').val('Try Sending Again').removeAttr('disabled').addClass('btn-danger');
    )


  constructor: (options) ->
    super(options)
    @original = @model
    @model = new @collection.model(_.omit(@original.attributes, 'created_at', 'updated_at', 'id'))
    @model.set('modifier_id', Number options.action) if options.action

    @model.bind("change:errors", () =>
      $('p.error-message').remove()
      $('.error').removeClass('error')
      _.each @model.get('errors'), (error,index) ->
        $('#'+index).closest('.control-group').addClass('error')
        $('#'+index).closest('.control-group .controls').append('<p class="help-block error-message">' + error + '</p>')
    )

  tooltip: (a) ->
    @$('#'+a.currentTarget.id).tooltip
      placement: "left"

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
        # console.log @model

      onDelete: (item) =>
        # console.log @model

  preview: (e) ->
    @model.set
      impacted_services: _.map($("input[name='impacted_service_ids[]']:checked"), (a) -> DssMessenger.impacted_services.get(a.value).attributes )

    modifier = DssMessenger.modifiers.get($("input[name='modifier_id[]']:checked").val()).get('description').split(':')[0]
    classification = DssMessenger.classifications.get($("input[name='classification_id[]']:checked").val()).get('description').split(':')[0]
    subject = modifier + ": " + classification + ": " + @model.get('subject')

    view = new DssMessenger.Views.Messages.PreviewView({model : @model})
    modal = new Backbone.BootstrapModal(content: view, title: subject, animate: true).open()

  render: ->
    @$el.html("<h1>Duplicate Message</h1>")
    @$el.append(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    _.defer =>
      @datetimePicker()
    
    return this
