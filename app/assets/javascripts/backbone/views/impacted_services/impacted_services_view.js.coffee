DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.impacted_servicesView extends Backbone.View
  template: JST["backbone/templates/impacted_services/impacted_services"]

  tagName: "option"

  render: ->
    @$el.attr('value', @model.get('id')).html(@template(@model.toJSON() ))
    return this
