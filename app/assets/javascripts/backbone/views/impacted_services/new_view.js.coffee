DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.NewView extends Backbone.View
  template: JST["backbone/templates/impacted_services/new"]

  events:
    "submit #new-impacted_services": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (impacted_services) =>
        @model = impacted_services
        window.location.hash = "/#{@model.id}"

      error: (impacted_services, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
