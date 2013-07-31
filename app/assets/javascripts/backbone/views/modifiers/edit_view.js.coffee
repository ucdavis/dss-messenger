DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.EditView extends Backbone.View
  template: JST["backbone/templates/modifiers/edit"]

  events:
    "click .icon-trash": "destroy"
    "change .pref_input": "update"
    "keypress .pref_input": "checkKey"
    "change input[type=checkbox]": "changeOpenEnded"

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
      description: @$("input[name='modifier']").val()

    @model.save(null,
      success: (modifiers) =>
        @model = modifiers
    )

  changeOpenEnded: ->
    @model.set
      open_ended: @$("input[type=checkbox]").is(':checked')

    @model.save(null,
      success: (modifiers) =>
        @model = modifiers
    )
    
  render: ->
    @$el.html(@template(@model.toJSON() ))
    @$('input[type=checkbox]').prop('checked', @model.get('open_ended'));

    this.$("form").backboneLink(@model)

    return this
