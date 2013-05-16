DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.NewView extends Backbone.View
  template: JST["backbone/templates/classifications/new"]

  events:
    "submit #new-classifications": "save"

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
      success: (classifications) =>
        @model = classifications
        window.location.hash = "/#{@model.id}"

      error: (classifications, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
