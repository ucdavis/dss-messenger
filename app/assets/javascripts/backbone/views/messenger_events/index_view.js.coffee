DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.IndexView extends Backbone.View
  template: JST["backbone/templates/messenger_events/index"]

  tagName: "select"

  initialize: () ->
    @options.messenger_events.bind('reset', @addAll)
    _.defer =>
      $('.selectpicker').selectpicker()

  addAll: () =>
    @$el.append('<option value="">Events</option>')
    @options.messenger_events.each(@addOne)

  addOne: (messenger_events) =>
    view = new DssMessenger.Views.messenger_events.messenger_eventsView({model : messenger_events})
    @$("#select_me_filter").append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(messenger_events: @options.messenger_events.toJSON() ))
    @addAll()

    return this

