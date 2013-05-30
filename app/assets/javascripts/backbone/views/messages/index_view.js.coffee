DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.IndexView extends Backbone.View
  template: JST["backbone/templates/messages/index"]

  events:
    "click .more" : "getMore"

  initialize: () ->
    @options.messages.bind('reset', @addAll)

  addAll: () =>
    @options.messages.each(@addOne)

  getMore: (e) =>
    e.stopPropagation()
    # @$el.append("<div class='overlay'><div class='loading'></div></div>")
    $(".pagination").hide() if ++@options.current >= @options.pages

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        page: @options.current
        # cl: classification
        # mo: modifier
        # is: service
        # me: mevent

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
