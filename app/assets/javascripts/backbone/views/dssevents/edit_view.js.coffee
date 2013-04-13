DssMessenger.Views.Dssevents ||= {}

class DssMessenger.Views.Dssevents.EditView extends Backbone.View
  template: JST["backbone/templates/dssevents/edit"]

  events:
    "submit #edit-dssevents": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (dssevents) =>
        @model = dssevents
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
