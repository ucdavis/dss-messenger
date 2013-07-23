DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.EditView extends Backbone.View
  template: JST["backbone/templates/classifications/edit"]

  events:
    "click .icon-trash": "destroy"
    "change .pref_input": "update"
    "keypress .pref_input": "checkKey"

  checkKey: (e) ->
    e.stopPropagation()
    @save if e.keyCode == 13


  destroy: () ->
    bootbox.confirm "Are you sure you want to delete <span class='confirm-name'>" + @model.escape("description") + "</span> ?", (result) =>
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
      description: @$("input[name='classification']").val()

    @model.save(null,
      success: (classifications) =>
        @model = classifications
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
