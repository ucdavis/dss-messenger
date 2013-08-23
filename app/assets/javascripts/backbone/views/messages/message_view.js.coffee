DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.MessageView extends Backbone.View
  template: JST["backbone/templates/messages/message"]
  show: JST["backbone/templates/messages/show"]

  events:
    "mouseenter .tooltip-archive"   : "tooltipArchive"
    "mouseenter .actions"           : "tooltipAction"
    "click      .tooltip-archive"   : "archive"
    "click      .accordion-heading" : "toggleAccordion"
    "mouseenter .tooltip-duplicate" : "tooltipDuplicate"
    "mouseenter .tooltip-destroy"   : "tooltipDestroy"
    "click      .tooltip-destroy"   : "destroy"

  tagName: "tr"

  archive: () ->
    @$el.addClass('archiving')
    # archive the message
    @model.save(closed:true,
      timeout: 10000 # 10 seconds
      wait:true
      success: (message) =>
        $("#archive-table, .table-title").show()
        $('#archive-table #mtable-head').after(@$el)
        @$el.removeClass('archiving')
        @$el.effect( "highlight", "slow" )
        @$('.archive-only').show()
        @$('.active-only').hide()
        #Hide the table titles if no more active messages
        @active = DssMessenger.messages.filter (messages) ->
          messages.get("closed") is false
        if @active.length is 0
          $("#active-table, .table-title").fadeOut()
      
        
      error: (message, jqXHR) =>
        message.set({errors: $.parseJSON(jqXHR.responseText)})
      )

    return false

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
    colors = ['info','success','inverse','important','warning']
    _.each DssMessenger.modifiers.models, (modifier,index) =>
      description = modifier.get('description').split(':')[0] # get part before the colon
      @$('.actions').append('<a href="#/'+@model.get('id')+'/duplicate/'+modifier.id+'" class="label label-'+colors[index%5]+'">'+description+'</a> ')
    
    _.defer =>
      modifier = @model.get('modifier')
      @$('.modifier-label').addClass('label-'+colors[(modifier.id-1)%5]).text(modifier.description.split(':')[0])
      if @model.get('closed')
        @$('.active-only').hide()
      else
        @$('.archive-only').hide()

    return this

  toggleAccordion: ->
    @$(".accordion-toggle-icon").toggleClass('icon-arrow-down')
    if $('#collapse'+@model.get('id')).length
      $('#collapse'+@model.get('id')).remove()
    else
      @$el.after(@show(@model.toFullJSON() ))

  tooltipArchive: ->
    @$('.tooltip-archive').tooltip
      title:"Archive without sending an email"
      placement: "top"
    @$('.tooltip-archive').tooltip('show')

  tooltipAction: ->
    @$('.actions').tooltip
      title:"Compose new message with the selected status filled in"
      placement: "top"
    @$('.actions').tooltip('show')

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
