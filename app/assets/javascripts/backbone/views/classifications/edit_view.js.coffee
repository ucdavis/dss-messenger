DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.EditView extends Backbone.View
  template: JST["backbone/templates/classifications/edit"]

  events:
    "submit #edit-classifications": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (classifications) =>
        @model = classifications
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
