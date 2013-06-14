DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.EditView extends Backbone.View
  template: JST["backbone/templates/impacted_services/edit"]

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

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.set
      name: @$("input[name='impacted_service']").val()

    @model.save(null,
      success: (impacted_services) =>
        @model = impacted_services
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
