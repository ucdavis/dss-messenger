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
        @$('#save-status').addClass('text-success').text('Saved successfully!').delay(5000).queue -> $(this).empty()

      error: =>
        @$('#save-status').addClass('text-error').text('Error saving').delay(5000).queue -> $(this).empty()
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this