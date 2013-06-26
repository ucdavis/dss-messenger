DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.ClassificationsView extends Backbone.View
  template: JST["backbone/templates/classifications/classifications"]

  tagName: "option"
  
  render: ->
    @$el.attr('value', @model.get('id')).html(@template(@model.toJSON() ))
    return this
