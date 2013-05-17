DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.ShowView extends Backbone.View
  template: JST["backbone/templates/modifiers/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
