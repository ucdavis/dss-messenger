DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.PreviewView extends Backbone.View
  template: JST["backbone/templates/messages/preview"]

  render: ->
    @$el.html(@template(@model.toFullJSON() ))
    return this
