DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.IndexView extends Backbone.View
  template: JST["backbone/templates/messenger_events/index"]

  tagName: "select"

  events:
    "change"          : "filter"

  initialize: () ->
    @options.messenger_events.bind('reset', @addAll)
    _.defer =>
      $('.selectpicker').selectpicker()

  addAll: () =>
    @$el.append('<option value="">Events</option>')
    @options.messenger_events.each(@addOne)

  addOne: (messenger_events) =>
    view = new DssMessenger.Views.messenger_events.messenger_eventsView({model : messenger_events})
    @$el.append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(messenger_events: @options.messenger_events.toJSON() ))
    @addAll()

    return this

  filter: (e) ->
    e.stopPropagation()
    mevent = @$el.val()
    classification = $("#filter_classifications li.selected").attr "rel"
    modifier = $("#filter_modifiers li.selected").attr "rel"
    service = $("#filter_impacted_services li.selected").attr "rel"

    $("#messages").append("<div class='overlay'><div class='loading'></div></div>")

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        page: DssMessenger.current,
        cl: classification if classification > 0,
        mo: modifier if modifier > 0,
        is: service if service > 0,
        me: mevent if mevent > 0

      success: (messages, a, b, c) =>
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
