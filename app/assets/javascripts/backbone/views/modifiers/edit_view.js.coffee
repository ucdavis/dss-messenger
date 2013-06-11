DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.EditView extends Backbone.View
  template: JST["backbone/templates/modifiers/edit"]

  events:
    "submit #edit-modifiers": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (modifiers) =>
        @model = modifiers
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
