DssMessenger.Views.Dssevents ||= {}

class DssMessenger.Views.Dssevents.DsseventsView extends Backbone.View
  template: JST["backbone/templates/dssevents/dssevents"]

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
