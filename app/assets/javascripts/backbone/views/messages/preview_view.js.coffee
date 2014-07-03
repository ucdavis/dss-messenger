DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.PreviewView extends Backbone.View
  template: JST["backbone/templates/messages/preview"]

  render: ->
    @$el.html(@template(@model.toFullJSON() ))
    @footer = DssMessenger.settings.where({item_name: "footer"})[0]

    @$el.append(@footer.get('item_value').replace(/\r\n|\n|\r/g, '<br />')) if @footer

    _.defer =>
      _.each @model.get("impacted_services"), (impacted_service) ->
        @$('#impacted_services_list').append('<li>' + impacted_service.name + '</li>')
      _.each @model.attributes, (a, b) ->
        if a is null
          @$('.'+b).hide()
        else
          @$('.'+b).hide() if a.length is 0

    return this
