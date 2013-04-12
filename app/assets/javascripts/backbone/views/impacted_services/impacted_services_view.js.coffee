DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.impacted_servicesView extends Backbone.View
  template: JST["backbone/templates/impacted_services/impacted_services"]

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
