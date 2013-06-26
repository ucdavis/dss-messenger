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
    if mevent != ''
      classification = $("input[name='cl_filter[]']:checked").val()
      modifier = $("input[name='mo_filter[]']:checked").val()
      service = $("input[name='is_filter[]']:checked").val()

      $("#messages").append("<div class='overlay'><div class='loading'></div></div>")

      @messages = new DssMessenger.Collections.MessagesCollection()
      @messages.fetch
        data:
          cl: classification
          mo: modifier
          is: service
          me: mevent

        success: (messages, a, b, c) =>
          @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
          $("#messages").html(@view.render().el)
          $('#reset-filters').removeClass('hidden')

        error: (messages, response) ->
          console.log "#{response.status}."
          $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
      return true
