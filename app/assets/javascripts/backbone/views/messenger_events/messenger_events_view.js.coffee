DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.messenger_eventsView extends Backbone.View
  template: JST["backbone/templates/messenger_events/messenger_events"]

  tagName: "option"

  render: ->
    @$el.attr('value', @model.get('id')).html(@template(@model.toJSON() ))
    return this

