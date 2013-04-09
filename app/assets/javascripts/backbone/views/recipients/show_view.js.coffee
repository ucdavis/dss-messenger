DssMessenger.Views.Recipients ||= {}

class DssMessenger.Views.Recipients.ShowView extends Backbone.View
  template: JST["backbone/templates/recipients/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
