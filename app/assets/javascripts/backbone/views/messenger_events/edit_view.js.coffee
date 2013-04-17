DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.EditView extends Backbone.View
  template: JST["backbone/templates/messenger_events/edit"]

  events:
    "submit #edit-messenger_events": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (messenger_events) =>
        @model = messenger_events
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
