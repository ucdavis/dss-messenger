DssMessenger.Views.Publishers ||= {}

class DssMessenger.Views.Publishers.EditView extends Backbone.View
  template: JST["backbone/templates/publishers/edit"]

  events:
    "change .pref_input": "update"
    "keypress .pref_input": "checkKey"
    "change input[type=checkbox]": "changeDefault"

  checkKey: (e) ->
    e.stopPropagation()
    @save if e.keyCode == 13

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.set
      name: @$("input[name='publisher']").val()

    @model.save(null,
      success: (publishers) =>
        @model = publishers
    )

  changeDefault: ->
    @model.set
      default: @$("input[type=checkbox]").is(':checked')

    @model.save(null,
      success: (modifiers) =>
        @model = modifiers
    )
    
  render: ->
    this.setElement(@template(@model.toJSON() ))
    @$('input[type=checkbox]').prop('checked', @model.get('default'))

    this.$("form").backboneLink(@model)

    return this
