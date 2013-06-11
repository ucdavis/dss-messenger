DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.ShowView extends Backbone.View
  template: JST["backbone/templates/classifications/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
