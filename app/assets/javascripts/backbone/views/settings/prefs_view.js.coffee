DssMessenger.Views.Settings ||= {}

class DssMessenger.Views.Settings.PrefsView extends Backbone.View
  template: JST["backbone/templates/settings/prefs"]

  initialize: ->
    @bind("cancel", @removeFromDOM)
    _.defer =>
      $("#configTabs a:first").tab "show"

  removeFromDOM: (modal) ->
    modal.remove()

  render: ->
    @$el.html(@template( ))

    _.defer =>
      $("#configTabs a[href=#" + @options.tab + "]").tab "show" unless @options.tab is null
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

      view = new DssMessenger.Views.Settings.EditFooterView(model: DssMessenger.settings.where({item_name: "footer"})[0])
      @$("#email_footer").html(view.render().el)

    return this
