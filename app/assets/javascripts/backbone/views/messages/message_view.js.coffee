DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.MessageView extends Backbone.View
  template: JST["backbone/templates/messages/message"]

  events:
    "mouseenter .tooltip-show"      : "tooltipShow"
    "mouseenter .tooltip-duplicate" : "tooltipDuplicate"
    "mouseenter .tooltip-destroy"   : "tooltipDestroy"
    "click      .tooltip-destroy"   : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toFullJSON() )).fadeIn()
    return this

  tooltipShow: ->
    @$('.tooltip-show').tooltip
      title:"Show"
      placement: "top"
    @$('.tooltip-show').tooltip('show')
    
  tooltipDuplicate: ->
    @$('.tooltip-duplicate').tooltip
      title:"Duplicate"
      placement: "top"
    @$('.tooltip-duplicate').tooltip('show')
    
  tooltipDestroy: ->
    @$('.tooltip-destroy').tooltip
      title:"Delete"
      placement: "top"
    @$('.tooltip-destroy').tooltip('show')
