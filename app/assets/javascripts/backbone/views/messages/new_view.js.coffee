DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.NewView extends Backbone.View
  template: JST["backbone/templates/messages/form"]

  events:
    "submit #message-form": "save"
    "focus #Recipients"	:	"tokenInput"
    "mouseenter .control-group"   : "tooltip"
    "click .message-preview"  : "preview"
    "click .config-link"  : "openConfig"
    "click .close"  : "resetGroup"
    "keypress input"  : "preventSubmit"

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
      view = new DssMessenger.Views.Classifications.FormIndexView(message: @model)
      @$("#classifications_select").html(view.render().el)

      view = new DssMessenger.Views.Modifiers.FormIndexView(message: @model)
      @$("#modifiers_select").html(view.render().el)

      view = new DssMessenger.Views.impacted_services.FormIndexView(message: @model)
      @$("#impacted_services_select").html(view.render().el)

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

  preventSubmit: (e) ->
    if e.keyCode is 13
      e.preventDefault()
      false

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
    @$('#'+a.currentTarget.id).tooltip('show')

  resetGroup: (e) ->
    group = $(e.target).data('group')
    $("#"+group+" input").attr('checked', false)

  openConfig: (e) ->
    @tab = $(e.target).data('tab')
    @view = new DssMessenger.Views.Settings.PrefsView(tab: @tab)
    modal = new Backbone.BootstrapModal(content: @view, title: "Preferences", cancelText: false, okText: "Dismiss").open()

  tokenInput: (e) ->
    $("input[name=recipient_uids]").tokenInput "/recipients",
      theme: "facebook"
      resultsFormatter: (item) ->
        extra = ''
        extra = "<div><small>#{item.member_count} members</small></div>" if item.member_count
        "<li title='" + item.name + "'>" + "<div>" + item.name + "</div>#{extra}</li>"
      tokenFormatter: (item) ->
        extra = ''
        extra = " (#{item.member_count} members)" if item.member_count
        "<li title='" + item.name + "'><p>" + item.name + extra + "</p></li>"

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

  preview: (e) ->
    @model.set
      impacted_services: _.map($("input[name='impacted_service_ids[]']:checked"), (a) -> DssMessenger.impacted_services.get(a.value).attributes )

    modifier = classification = ""
    modifier_id = $("input[name='modifier_id[]']:checked").val()
    modifier = DssMessenger.modifiers.get(modifier_id).get('description').split(':')[0] + ": " if modifier_id > 0
    classification_id = $("input[name='classification_id[]']:checked").val()
    classification = DssMessenger.classifications.get(classification_id).get('description').split(':')[0] + ": " if classification_id > 0
    subject = modifier + classification + @model.get('subject')

    view = new DssMessenger.Views.Messages.PreviewView({model : @model})
    modal = new Backbone.BootstrapModal(content: view, title: subject, cancelText: false, okText: "Dismiss").open()

  render: ->
    @$el.html("<h1>New Message</h1>")
    @$el.append(@template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)

    _.defer =>
      @datetimePicker()
    
    return this
