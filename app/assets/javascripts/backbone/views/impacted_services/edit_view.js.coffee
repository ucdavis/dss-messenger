DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.EditView extends Backbone.View
  template: JST["backbone/templates/impacted_services/edit"]

  events:
    "submit #edit-impacted_services": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (impacted_services) =>
        @model = impacted_services
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
