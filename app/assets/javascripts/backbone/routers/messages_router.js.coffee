class DssMessenger.Routers.MessagesRouter extends Backbone.Router
  initialize: (options) ->
    DssMessenger.messages = new DssMessenger.Collections.MessagesCollection(options.messages)
    DssMessenger.pages = options.pages
    DssMessenger.current = options.current
    # Initialize filters
    DssMessenger.filterClassification = DssMessenger.filterModifier = DssMessenger.filterService = 0

    DssMessenger.classifications = new DssMessenger.Collections.ClassificationsCollection(options.classifications)
    DssMessenger.modifiers = new DssMessenger.Collections.ModifiersCollection(options.modifiers)
    DssMessenger.impacted_services = new DssMessenger.Collections.impacted_servicesCollection(options.impacted_services)
    
  routes:
    "new"           : "newMessage"
    "index"         : "index"
    "prefs"         : "Preferences"
    "about"         : "About"
    ":id/duplicate" : "duplicate"
    ":id"           : "show"
    ".*"            : "index"

  newMessage: ->
    @view = new DssMessenger.Views.Messages.NewView(collection: DssMessenger.messages)
    $("#filters-sidebar").hide()
    $("#messages").html(@view.render().el)

  index: ->
    $("#filters-sidebar").fadeIn()
    @view = new DssMessenger.Views.Messages.IndexView(messages: DssMessenger.messages, pages: DssMessenger.pages, current: DssMessenger.current)
    $("#messages").html(@view.render().el)
    @view = new DssMessenger.Views.Classifications.IndexView(classifications: DssMessenger.classifications)
    $("#filter_classifications").html(@view.render().el)
    @view = new DssMessenger.Views.Modifiers.IndexView(modifiers: DssMessenger.modifiers)
    $("#filter_modifiers").html(@view.render().el)
    @view = new DssMessenger.Views.impacted_services.IndexView(impacted_services: DssMessenger.impacted_services)
    $("#filter_impacted_services").html(@view.render().el)
    @view = new DssMessenger.Views.Messages.ResetFiltersView()
    $("#reset_filters").html(@view.render().el)

  show: (id) ->
    message = DssMessenger.messages.get(id)

    @view = new DssMessenger.Views.Messages.ShowView(model: message)
    $("#filters-sidebar").hide()
    $("#messages").html(@view.render().el)

  duplicate: (id) ->
    message = DssMessenger.messages.get(id)

    @view = new DssMessenger.Views.Messages.DuplicateView(collection: DssMessenger.messages, model: message)
    $("#filters-sidebar").hide()
    $("#messages").html(@view.render().el)

  Preferences: ->
    @view = new DssMessenger.Views.Settings.PrefsView()
    $("#filters-sidebar").hide()
    $("#messages").html(@view.render().el)

  About: ->
    @view = new DssMessenger.Views.Settings.AboutView()
    $("#messages").append(@view.render().el)