DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.IndexView extends Backbone.View
  template: JST["backbone/templates/messages/index"]

  events:
    "click .more" : "getMore"

  initialize: () ->
    @options.messages.bind('reset', @addAll)

  addAll: () =>
    @options.messages.each(@addOne)
    console.log @options.current, @options.pages
    _.defer =>
      # this will un-hide the 'show more' button if there is more messages
      $(".pagination").removeClass('hidden') if @options.current < @options.pages
      # this will affix the table header when scrolled
      $("#mtable-head").affix offset: $("#messages-table").position().top - 40
      $("#mtable-head th").each ->
        $(this).width $(this).width()

  getMore: (e) =>
    e.preventDefault()
    e.stopPropagation()
    # @$el.append("<div class='overlay'><div class='loading'></div></div>")
    $(".pagination").fadeOut() if ++@options.current >= @options.pages
    classification = $("input[name='cl_filter[]']:checked").val()
    modifier = $("input[name='mo_filter[]']:checked").val()
    service = $("input[name='is_filter[]']:checked").val()
    mevent = $("input[name='me_filter[]']:checked").val()

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        page: @options.current,
        cl: classification,
        mo: modifier,
        is: service,
        me: mevent

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
