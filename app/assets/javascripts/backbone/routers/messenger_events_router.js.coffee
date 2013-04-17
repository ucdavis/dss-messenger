class DssMessenger.Routers.messenger_eventsRouter extends Backbone.Router
  initialize: (options) ->
    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.reset options.messenger_events

  routes:
    "new"      : "newmessenger_events"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newmessenger_events: ->
    @view = new DssMessenger.Views.messenger_events.NewView(collection: @messenger_events)
    $("#messenger_events").html(@view.render().el)

  index: ->
    @view = new DssMessenger.Views.messenger_events.IndexView(messenger_events: @messenger_events)
    $("#messenger_events").html(@view.render().el)

  show: (id) ->
    messenger_events = @messenger_events.get(id)

    @view = new DssMessenger.Views.messenger_events.ShowView(model: messenger_events)
    $("#messenger_events").html(@view.render().el)

  edit: (id) ->
    messenger_events = @messenger_events.get(id)

    @view = new DssMessenger.Views.messenger_events.EditView(model: messenger_events)
    $("#messenger_events").html(@view.render().el)
