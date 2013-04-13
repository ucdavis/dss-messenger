DssMessenger.Views.Dssevents ||= {}

class DssMessenger.Views.Dssevents.NewView extends Backbone.View
  template: JST["backbone/templates/dssevents/new"]

  events:
    "submit #new-dssevents": "save"

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
      success: (dssevents) =>
        @model = dssevents
        window.location.hash = "/#{@model.id}"

      error: (dssevents, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
