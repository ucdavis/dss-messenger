DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.ActiveMessageView extends Backbone.View
  template: JST["backbone/templates/messages/active_message"]
  show: JST["backbone/templates/messages/show"]

  events:
    "mouseenter .tooltip-archive"   : "tooltipArchive"
    "click      .tooltip-archive"   : "archive"
    "click      .accordion-heading" : "toggleAccordion"

  tagName: "tr"

  archive: () ->
    bootbox.confirm "Are you sure you want to archive <span class='confirm-name'>" + @model.escape("subject") + "</span> without sending a message?", (result) =>
      if result
        # archive the message
        @model.save(closed:true,
          timeout: 10000 # 10 seconds
          wait:true
          success: (message) =>
            @$el.toggle("highlight", {color: "#700000"}, 1000)
            
          error: (message, jqXHR) =>
            message.set({errors: $.parseJSON(jqXHR.responseText)})
          )
          
        
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

  tooltipArchive: ->
    @$('.tooltip-archive').tooltip
      title:"Archive"
      placement: "top"
    @$('.tooltip-archive').tooltip('show')

