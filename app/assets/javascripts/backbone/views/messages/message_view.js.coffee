DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.MessageView extends Backbone.View
  template: JST["backbone/templates/messages/message"]
  show: JST["backbone/templates/messages/show"]

  events:
    "mouseenter .tooltip-show"      : "tooltipShow"
    "mouseenter .tooltip-duplicate" : "tooltipDuplicate"
    "mouseenter .tooltip-destroy"   : "tooltipDestroy"
    "click      .tooltip-destroy"   : "destroy"
    "click      .accordion-heading" : "toggleAccordion"

  tagName: "tr"

  destroy: () ->
    bootbox.confirm "Are you sure you want to delete <span class='confirm-name'>" + @model.escape("subject") + "</span>?", (result) =>
      if result
        # delete the message and remove from log
        @model.destroy()
        @$el.toggle("highlight", {color: "#700000"}, 1000)
        
    # dismiss the dialog
    @$(".modal-header a.close").trigger "click"

    return false

  render: ->
    @$el.html(@template(@model.toFullJSON() )).fadeIn()
    return this

  toggleAccordion: ->
    @$(".accordion-toggle-icon").toggleClass('icon-arrow-down')
    if $('#collapse'+@model.get('id')).length
      $('#collapse'+@model.get('id')).remove()
    else
      @$el.after(@show(@model.toFullJSON() ))

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
