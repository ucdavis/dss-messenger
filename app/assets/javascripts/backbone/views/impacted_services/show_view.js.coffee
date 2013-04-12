DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.ShowView extends Backbone.View
  template: JST["backbone/templates/impacted_services/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
