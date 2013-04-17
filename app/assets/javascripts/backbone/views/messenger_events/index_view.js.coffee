DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.IndexView extends Backbone.View
  template: JST["backbone/templates/messenger_events/index"]

  initialize: () ->
    @options.messenger_events.bind('reset', @addAll)

  addAll: () =>
    @options.messenger_events.each(@addOne)

  addOne: (messenger_events) =>
    view = new DssMessenger.Views.messenger_events.messenger_eventsView({model : messenger_events})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(messenger_events: @options.messenger_events.toJSON() ))
    @addAll()

    return this
