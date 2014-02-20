DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.FormView extends Backbone.View
  template: JST["backbone/templates/classifications/form"]

  initialize: (options) ->
    @options = options or {}

  render: ->
    @$el.html(@template(@model.toJSON() ))
    @$("input").attr('checked', true) if @model.get('id') is @options.message.get('classification_id')

    this.$("form").backboneLink(@model)

    return this
