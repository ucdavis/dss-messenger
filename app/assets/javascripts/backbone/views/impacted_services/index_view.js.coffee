DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.IndexView extends Backbone.View
  template: JST["backbone/templates/impacted_services/index"]

  tagName: "select"

  events:
    "change"          : "filter"
  
  initialize: () ->
    @options.impacted_services.bind('reset', @addAll)
    _.defer =>
      @$el.selectpicker()

  addAll: () =>
    @$el.append('<option value="">Impacted Services</option>')
    @options.impacted_services.each(@addOne)

  addOne: (impacted_services) =>
    view = new DssMessenger.Views.impacted_services.impacted_servicesView({model : impacted_services})
    @$el.append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(impacted_services: @options.impacted_services.toJSON() ))
    @addAll()

    return this

  filter: (e) ->
    e.stopPropagation()
    service = @$el.val()
    classification = $("#filter_classifications li.selected").attr "rel"
    modifier = $("#filter_modifiers li.selected").attr "rel"
    mevent = $("#filter_messenger_events li.selected").attr "rel"

    $("#messages").append("<div class='overlay'><div class='loading'></div></div>")

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        page: DssMessenger.current,
        cl: classification if classification > 0,
        mo: modifier if modifier > 0,
        is: service if service > 0,
        me: mevent if mevent > 0

      success: (messages) =>
        if @messages.length > 0
          DssMessenger.pages = @messages.first().get('pages')
          DssMessenger.current = @messages.first().get('current')
        else
          DssMessenger.pages = 0
          DssMessenger.current = 0
          
        @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
        $("#messages").html(@view.render().el)
        $('#reset-filters').removeClass('hidden')

      error: (messages, response) ->
        console.log "#{response.status}."
        $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")

    return true

