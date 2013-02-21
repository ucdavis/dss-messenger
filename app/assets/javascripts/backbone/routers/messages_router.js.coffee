class DssMessenger.Routers.MessagesRouter extends Backbone.Router
  initialize: (options) ->
    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.reset options.messages

  routes:
    "new"      : "newMessage"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newMessage: ->
    @view = new DssMessenger.Views.Messages.NewView(collection: @messages)
    $("#messages").append(@view.render().el)

  index: ->
    @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
    $("#messages").html(@view.render().el)

  show: (id) ->
    message = @messages.get(id)

    @view = new DssMessenger.Views.Messages.ShowView(model: message)
    $("#messages").append(@view.render().el)

  edit: (id) ->
    message = @messages.get(id)

    @view = new DssMessenger.Views.Messages.EditView(model: message)
    $("#messages").append(@view.render().el)
