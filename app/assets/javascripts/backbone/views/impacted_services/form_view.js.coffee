DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.FormView extends Backbone.View
  template: JST["backbone/templates/impacted_services/form"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    @current_services = @options.message.get('impacted_services')
    _.each @current_services, (current_service) =>
      @$("input").attr('checked', true) if @model.get('id') is current_service.id

    this.$("form").backboneLink(@model)

    return this
