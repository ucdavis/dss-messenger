DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.EditView extends Backbone.View
  template: JST["backbone/templates/modifiers/edit"]

  events:
    "click .icon-trash": "destroy"
    "change .pref_input": "update"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.set
      description: $("input[name='modifier']").val()

    @model.save(null,
      success: (modifiers) =>
        @model = modifiers
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
