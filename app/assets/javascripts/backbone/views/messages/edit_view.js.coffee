DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.EditView extends Backbone.View
  template: JST["backbone/templates/messages/edit"]

  events:
    "submit #edit-message": "update"
    "focus .datepicker"	:	"displayPicker"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (message) =>
        @model = message
        window.location.hash = "/#{@model.id}"
    )

  displayPicker: (e) ->
    $('.datepicker').datetimepicker()


  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
