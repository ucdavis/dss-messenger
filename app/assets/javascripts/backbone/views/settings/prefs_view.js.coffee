DssMessenger.Views.Settings ||= {}

class DssMessenger.Views.Settings.PrefsView extends Backbone.View
  template: JST["backbone/templates/settings/prefs"]

  render: ->
    @$el.html(@template( ))

    _.defer =>
      $("#configTabs a:first").tab "show"
      # display loading gif while loading content
      $("#classifications_prefs").html("<div class='loading'></div>")
      $("#modifiers_prefs").html("<div class='loading'></div>")
      $("#impacted_services_prefs").html("<div class='loading'></div>")
      # load the inputs originally laoded from the router
      view = new DssMessenger.Views.Classifications.EditIndexView(classifications: DssMessenger.classifications)
      @$("#classifications_prefs").html(view.render().el)

      $("#modifiers_prefs").empty()
      DssMessenger.modifiers.each (modifier) ->
        view = new DssMessenger.Views.Modifiers.EditView({model : modifier})
        @$("#modifiers_prefs").append(view.render().el)
      @view = new DssMessenger.Views.Modifiers.NewView(collection: DssMessenger.modifiers)
      $("#modifiers_prefs").append(@view.render().el)

      $("#impacted_services_prefs").empty()
      DssMessenger.impacted_services.each (impacted_service) ->
        view = new DssMessenger.Views.impacted_services.EditView({model : impacted_service})
        @$("#impacted_services_prefs").append(view.render().el)
      @view = new DssMessenger.Views.impacted_services.NewView(collection: DssMessenger.impacted_services)
      $("#impacted_services_prefs").append(@view.render().el)

    return this
