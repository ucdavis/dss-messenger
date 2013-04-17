DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.NewView extends Backbone.View
  template: JST["backbone/templates/messenger_events/new"]

  events:
    "submit #new-messenger_events": "save"

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
      success: (messenger_events) =>
        @model = messenger_events
        window.location.hash = "/#{@model.id}"

      error: (messenger_events, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
