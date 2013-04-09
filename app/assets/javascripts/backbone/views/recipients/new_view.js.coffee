DssMessenger.Views.Recipients ||= {}

class DssMessenger.Views.Recipients.NewView extends Backbone.View
  template: JST["backbone/templates/recipients/new"]

  events:
    "submit #new-recipient": "save"

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
      success: (recipient) =>
        @model = recipient
        window.location.hash = "/#{@model.id}"

      error: (recipient, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
