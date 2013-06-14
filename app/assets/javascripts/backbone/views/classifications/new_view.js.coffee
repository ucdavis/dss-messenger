DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.NewView extends Backbone.View
  template: JST["backbone/templates/classifications/new"]

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
      success: (classifications) =>
        @model = classifications

      error: (classifications, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
