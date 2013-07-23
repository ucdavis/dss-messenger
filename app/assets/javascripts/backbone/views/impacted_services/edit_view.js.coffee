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
    bootbox.confirm "Are you sure you want to delete <span class='confirm-name'>" + @model.escape("name") + "</span> ?", (result) =>
      if result
        # delete the object and remove from view
        @model.destroy()
        this.remove()
        
    # dismiss the dialog
    @$(".modal-header a.close").trigger "click"

    return false

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
