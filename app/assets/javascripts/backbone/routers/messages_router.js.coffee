class DssMessenger.Routers.MessagesRouter extends Backbone.Router
  initialize: (options) ->
    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.reset options.messages
    @pages = options.pages
    @current = options.current

    @classifications = new DssMessenger.Collections.ClassificationsCollection()
    @classifications.fetch
      success: (classifications) =>
        @classifications = classifications

      error: (classifications, response) ->
        console.log "#{response.status}."

    @modifiers = new DssMessenger.Collections.ModifiersCollection()
    @modifiers.fetch
      success: (modifiers) =>
        @modifiers = modifiers

      error: (modifiers, response) ->
        console.log "#{response.status}."

    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch
      success: (impacted_services) =>
        @impacted_services = impacted_services

      error: (impacted_services, response) ->
        console.log "#{response.status}."

    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.fetch
      success: (messenger_events) =>
        @messenger_events = messenger_events

      error: (messenger_events, response) ->
        console.log "#{response.status}."

  routes:
    "new"           : "newMessage"
    "index"         : "index"
    "prefs"         : "Preferences"
    ":id/duplicate" : "duplicate"
    ":id"           : "show"
    ".*"            : "index"

  newMessage: ->
    @view = new DssMessenger.Views.Messages.NewView(collection: @messages)
    $("#filters-sidebar").hide()
    $("#messages").html(@view.render().el)

  index: ->
    $("#filters-sidebar").fadeIn()
    @view = new DssMessenger.Views.Messages.IndexView(messages: @messages, pages: @pages, current: @current)
    $("#messages").html(@view.render().el)
    @view = new DssMessenger.Views.Classifications.IndexView(classifications: @classifications)
    $("#filter_classifications").html(@view.render().el)
    @view = new DssMessenger.Views.Modifiers.IndexView(modifiers: @modifiers)
    $("#filter_modifiers").html(@view.render().el)
    @view = new DssMessenger.Views.impacted_services.IndexView(impacted_services: @impacted_services)
    $("#filter_impacted_services").html(@view.render().el)
    @view = new DssMessenger.Views.messenger_events.IndexView(messenger_events: @messenger_events)
    $("#filter_messenger_events").html(@view.render().el)

  show: (id) ->
    message = @messages.get(id)

    @view = new DssMessenger.Views.Messages.ShowView(model: message)
    $("#filters-sidebar").hide()
    $("#messages").html(@view.render().el)

  duplicate: (id) ->
    message = @messages.get(id)

    @view = new DssMessenger.Views.Messages.DuplicateView(collection: @messages, model: message)
    $("#filters-sidebar").hide()
    $("#messages").html(@view.render().el)

  Preferences: ->
    @view = new DssMessenger.Views.Messages.PrefsView(collection: @messages)
    $("#messages").append(@view.render().el)
    