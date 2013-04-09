DssMessenger.Views.Recipients ||= {}

class DssMessenger.Views.Recipients.EditView extends Backbone.View
  template: JST["backbone/templates/recipients/edit"]

  events:
    "submit #edit-recipient": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (recipient) =>
        @model = recipient
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
