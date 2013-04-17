DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.ShowView extends Backbone.View
  template: JST["backbone/templates/messenger_events/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
