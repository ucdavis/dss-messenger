DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.PreviewView extends Backbone.View
  template: JST["backbone/templates/messages/preview"]

  render: ->
    @$el.html(@template(@model.toFullJSON() ))
    
    _.defer =>
      _.each @model.get("impacted_services"), (impacted_service) ->
        @$('#impacted_services_list').append('<li>' + impacted_service.name + '</li>')
      _.each @model.attributes, (a, b) ->
        console.log b,a
        @$('.'+b).hide() if a is null or []
    
    return this
