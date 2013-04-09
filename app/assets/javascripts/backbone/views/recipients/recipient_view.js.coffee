DssMessenger.Views.Recipients ||= {}

class DssMessenger.Views.Recipients.RecipientView extends Backbone.View
  template: JST["backbone/templates/recipients/recipient"]

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
