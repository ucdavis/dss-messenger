DssMessenger.Views.Dssevents ||= {}

class DssMessenger.Views.Dssevents.ShowView extends Backbone.View
  template: JST["backbone/templates/dssevents/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
