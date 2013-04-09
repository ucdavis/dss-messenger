class DssMessenger.Routers.RecipientsRouter extends Backbone.Router
  initialize: (options) ->
    @recipients = new DssMessenger.Collections.RecipientsCollection()
    @recipients.reset options.recipients

  routes:
    "new"      : "newRecipient"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newRecipient: ->
    @view = new DssMessenger.Views.Recipients.NewView(collection: @recipients)
    $("#recipients").html(@view.render().el)

  index: ->
    @view = new DssMessenger.Views.Recipients.IndexView(recipients: @recipients)
    $("#recipients").html(@view.render().el)

  show: (id) ->
    recipient = @recipients.get(id)

    @view = new DssMessenger.Views.Recipients.ShowView(model: recipient)
    $("#recipients").html(@view.render().el)

  edit: (id) ->
    recipient = @recipients.get(id)

    @view = new DssMessenger.Views.Recipients.EditView(model: recipient)
    $("#recipients").html(@view.render().el)
