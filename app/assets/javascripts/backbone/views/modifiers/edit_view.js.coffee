DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.EditView extends Backbone.View
  template: JST["backbone/templates/modifiers/edit"]

  events:
    "click .icon-trash": "destroy"
    "change .pref_input": "update"
    "keypress .pref_input": "checkKey"

  checkKey: (e) ->
    e.stopPropagation()
    @save if e.keyCode == 13


  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.set
      description: @$("input[name='modifier']").val()

    @model.save(null,
      success: (modifiers) =>
        @model = modifiers
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
