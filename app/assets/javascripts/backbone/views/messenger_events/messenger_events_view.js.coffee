DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.messenger_eventsView extends Backbone.View
  template: JST["backbone/templates/messenger_events/messenger_events"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
