DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.IndexView extends Backbone.View
  template: JST["backbone/templates/messenger_events/index"]

  events:
    "click #reset-filters" : "reset"

  initialize: () ->
    @options.messenger_events.bind('reset', @addAll)

  addAll: () =>
    @options.messenger_events.each(@addOne)

  addOne: (messenger_events) =>
    view = new DssMessenger.Views.messenger_events.messenger_eventsView({model : messenger_events})
    @$("#select_me_filter").append(view.render().el)

  render: =>
    @$el.html(@template(messenger_events: @options.messenger_events.toJSON() ))
    @addAll()

    return this

  reset: (e) ->
    e.stopPropagation()
    $('#filters-form input[type="radio"]').each -> $(this).prop 'checked', false
    $("#messages").append("<div class='overlay'><div class='loading'></div></div>")

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch

      success: (messages) =>
        @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
        $("#messages").html(@view.render().el)
	    $('#reset-filters').addClass('hidden')

      error: (messages, response) ->
        console.log "#{response.status}."
        $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
    return false

