DssMessenger.Views.Settings ||= {}

class DssMessenger.Views.Settings.EditFooterView extends Backbone.View
  template: JST["backbone/templates/settings/edit_footer"]

  events:
    "change .pref_input": "update"
    "click .save": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.set
      item_value: @$("textarea").val()

    @model.save(null,
      timeout: 30000
      success: (settings) =>
        @model = settings
        @$('button.save').addClass('btn-success').text('Saved')
      error: =>
        @$('button.save').addClass('btn-danger').text('Error')
    )

  render: ->
    console.log @model
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
