DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.PreviewView extends Backbone.View
  template: JST["backbone/templates/messages/preview"]

  render: ->
    @$el.html(@template(@model.toFullJSON() ))
    @footer = DssMessenger.settings.where({item_name: "footer"})[0]
    @$el.append(@footer.get('item_value'))
    
    _.defer =>
      _.each @model.get("impacted_services"), (impacted_service) ->
        @$('#impacted_services_list').append('<li>' + impacted_service.name + '</li>')
      _.each @model.attributes, (a, b) ->
        if Object::toString.call(a) is "[object Array]"
          @$('.'+b).hide() if a.length is 0
        else
          @$('.'+b).hide() if (a is null or a is '')
    
    return this
