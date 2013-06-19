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
    bootbox.confirm "Are you sure you want to delete " + @model.escape("subject") + "?", (result) =>
      if result
        # delete the message and remove from log
        @model.destroy()
        this.remove()
        
    # dismiss the dialog
    @$(".modal-header a.close").trigger "click"

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
