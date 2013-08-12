DssMessenger.Views.Settings ||= {}

class DssMessenger.Views.Settings.EditFooterView extends Backbone.View
  template: JST["backbone/templates/settings/edit_footer"]

  events:
    "change #email-footer-text": "update"
    'click .etch-save': 'update'
    'mousedown .editable': 'editableClick'

  editableClick: etch.editableInit

  initialize: ->
    @model.bind('save', @update)

  update: (e) =>
    @model.set
      item_value: $("#email-footer-text").html()

    @model.save(null,
      timeout: 30000
      success: (settings) =>
        @model = settings
        @$('#save-status').addClass('text-success').text('Saved successfully!').delay(10000).queue -> $(this).empty()
        
      error: =>
        @$('#save-status').addClass('text-error').text('Error saving').delay(10000).queue -> $(this).empty()
    )
    
  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
