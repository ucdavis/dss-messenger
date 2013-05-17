DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.NewView extends Backbone.View
  template: JST["backbone/templates/modifiers/new"]

  events:
    "submit #new-modifiers": "save"

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
      success: (modifiers) =>
        @model = modifiers
        window.location.hash = "/#{@model.id}"

      error: (modifiers, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
