DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.ModifiersView extends Backbone.View
  template: JST["backbone/templates/modifiers/modifiers"]

  tagName: "option"

  render: ->
    @$el.attr('value', @model.get('id')).html(@template(@model.toJSON() ))
    return this
