DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.MessageView extends Backbone.View
  template: JST["backbone/templates/messages/message"]
  show: JST["backbone/templates/messages/show"]

  events:
    "mouseenter .tooltip-archive"   : "tooltipArchive"
    "mouseenter .actions"           : "tooltipAction"
    "click      .tooltip-archive"   : "toggleArchive"
    "click      .tooltip-open"      : "toggleArchive"
    "click      .accordion-heading" : "toggleAccordion"
    "mouseenter .tooltip-open"      : "tooltipOpen"
    "mouseenter .tooltip-duplicate" : "tooltipDuplicate"
    "mouseenter .tooltip-destroy"   : "tooltipDestroy"
    "click      .tooltip-destroy"   : "destroy"

  tagName: "tr"

  toggleArchive: () ->
    @$el.addClass('archiving')
    newStatus = !@model.get('closed')

    # Collapse show view if visible
    @toggleAccordion() if $('#collapse' + @model.get('id')).length
    
    # Archive the message
    @model.save(closed:newStatus,
      timeout: 10000 # 10 seconds
      wait: true
      success: (message) =>
        if newStatus
          $("#archive-table, .table-title").show()
          $('#archive-table #mtable-head').after(@$el)
          @$('.archive-only').show()
          @$('.active-only').hide()
        else
          $("#active-table, .table-title").show()
          $('#active-table tr:last').after(@$el)
          @$('.archive-only').hide()
          @$('.active-only').show()

        @$el.removeClass('archiving')
        @$el.effect( "highlight", "slow" )
        
        # Hide the table titles if there are no more active messages
        @active = DssMessenger.messages.filter (messages) ->
          messages.get("closed") is false
        @archive = DssMessenger.messages.filter (messages) ->
          messages.get("closed") is true
        if @active.length is 0
          $("#active-table, .table-title").fadeOut()
        if @archive.length is 0
          $("#archive-table, .table-title").fadeOut()
      
      error: (message, jqXHR) =>
        message.set({errors: $.parseJSON(jqXHR.responseText)})
      )

    return false

  destroy: () ->
    bootbox.confirm "Are you sure you want to delete <span class='confirm-name'>" + @model.escape("subject") + "</span>?", (result) =>
      if result
        # Delete the message and remove it from the log
        @model.destroy()
        @$el.toggle("highlight", {color: "#700000"}, 1000)

        # Collapse show view if visible
        @toggleAccordion() if $('#collapse' + @model.get('id')).length

    # Dismiss the dialog
    @$(".modal-header a.close").trigger "click"

    return false

  render: ->
    @$el.html(@template(@model.toFullJSON())).fadeIn()
    
    colors = ['info', 'success', 'inverse', 'important', 'warning']

    _.each DssMessenger.modifiers.models, (modifier,index) =>
      description = modifier.get('description').split(':')[0] # get part before the colon
      @$('.actions').append('<a href="#/' + @model.get('id') + '/duplicate/' + modifier.id + '" class="label label-' + colors[index % 5] + '">' + description + '</a>')
    
    _.defer =>
      modifier = @model.get('modifier')
      
      @$('.modifier-label').addClass('label-' + colors[(modifier.id - 1) % 5]).text(modifier.description.split(':')[0]) unless modifier is null
      
      if @model.get('closed')
        @$('.active-only').hide()
      else
        @$('.archive-only').hide()

    return this

  toggleAccordion: ->
    @$(".accordion-toggle-icon").toggleClass('icon-arrow-down')
    
    if $('#collapse' + @model.get('id')).length
      $('#collapse' + @model.get('id')).remove()
    else
      @$el.after(@show(@model.toFullJSON() ))

  tooltipArchive: ->
    @$('.tooltip-archive').tooltip('show')

  tooltipOpen: ->
    @$('.tooltip-open').tooltip('show')

  tooltipAction: ->
    @$('.actions').tooltip('show')

  tooltipDuplicate: ->
    @$('.tooltip-duplicate').tooltip('show')

  tooltipDestroy: ->
    @$('.tooltip-destroy').tooltip('show')
