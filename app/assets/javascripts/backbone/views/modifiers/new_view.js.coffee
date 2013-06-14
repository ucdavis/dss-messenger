DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.NewView extends Backbone.View
  template: JST["backbone/templates/modifiers/new"]

  events:
    "change .pref_input": "save"

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

    @model.set
      description: @$("input[name='description']").val()

    @collection.create(@model.toJSON(),
      success: (modifiers) =>
        @model = modifiers

      error: (modifiers, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
