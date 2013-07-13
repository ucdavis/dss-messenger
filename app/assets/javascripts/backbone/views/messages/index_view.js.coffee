DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.IndexView extends Backbone.View
  template: JST["backbone/templates/messages/index"]

  events:
    "click .more" : "getMore"

  initialize: () ->
    @options.messages.bind('reset', @addAll)

  addAll: () =>
    @options.messages.each(@addOne)
    console.log DssMessenger.current, DssMessenger.pages
    _.defer =>
      # this will un-hide the 'show more' button if there is more messages
      $(".pagination").removeClass('hidden') if DssMessenger.current < DssMessenger.pages
      # this will affix the table header when scrolled
      $("#mtable-head").affix offset: $("#messages-table").position().top - 40
      $("#mtable-head th").each ->
        $(this).width $(this).width()

  getMore: (e) =>
    e.preventDefault()
    e.stopPropagation()
    # @$el.append("<div class='overlay'><div class='loading'></div></div>")
    $(".pagination").fadeOut() if ++DssMessenger.current >= DssMessenger.pages
    classification = $("#filter_classifications li.selected").attr "rel"
    modifier = $("#filter_modifiers li.selected").attr "rel"
    service = $("#filter_impacted_services li.selected").attr "rel"
    mevent = $("#filter_messenger_events li.selected").attr "rel"

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        page: DssMessenger.current,
        cl: classification if classification > 0,
        mo: modifier if modifier > 0,
        is: service if service > 0,
        me: mevent if mevent > 0

      success: (messages) =>
        @options.messages.reset(messages.models)

      error: (messages, response) ->
        console.log "#{response.status}."
        $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
    
  addOne: (message) =>
    view = new DssMessenger.Views.Messages.MessageView({model : message})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(messages: @options.messages.toJSON() ))
    @addAll()

    return this
