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
      view = new DssMessenger.Views.Classifications.EditIndexView()
      @$("#classifications_prefs").html(view.render().el)

      view = new DssMessenger.Views.Modifiers.EditIndexView()
      @$("#modifiers_prefs").html(view.render().el)

      view = new DssMessenger.Views.impacted_services.EditIndexView()
      @$("#impacted_services_prefs").html(view.render().el)

    return this
