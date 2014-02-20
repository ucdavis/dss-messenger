DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.FormView extends Backbone.View
  template: JST["backbone/templates/modifiers/form"]

  initialize: (options) ->
    @options = options

  render: ->
    @$el.html(@template(@model.toJSON() ))
    @$("input").attr('checked', true) if @model.get('id') is @options.message.get('modifier_id')

    this.$("form").backboneLink(@model)

    return this
