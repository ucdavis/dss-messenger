DssMessenger.Views.Publishers ||= {}

class DssMessenger.Views.Publishers.FormView extends Backbone.View
  template: JST["backbone/templates/publishers/form"]

  initialize: (options) ->
    @options = options or {}

  render: ->
    @$el.html(@template(@model.toJSON() ))
    @current_publishers = @options.message.get('publishers')

    # Should check the previously checked publishers or the default publisher if
    # none have been checked
    _.each @current_publishers, (current_publisher) =>
      @$("input").attr('checked', true) if @model.get('id') is current_publisher.id

    this.$("form").backboneLink(@model)

    return this
