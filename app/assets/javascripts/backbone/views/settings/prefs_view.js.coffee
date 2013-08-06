DssMessenger.Views.Settings ||= {}

class DssMessenger.Views.Settings.PrefsView extends Backbone.View
  template: JST["backbone/templates/settings/prefs"]

  initialize: ->
    DssMessenger.classifications.bind("change", () =>
      this.render()
    )
    DssMessenger.modifiers.bind("change", () =>
      this.render()
    )
    DssMessenger.impacted_services.bind("change", () =>
      this.render()
    )

  render: ->
    @$el.html(@template( ))

    _.defer =>
      $("#configTabs a:first").tab "show"
      # display loading gif while loading content
      $("#classifications_select").html("<div class='loading'></div>")
      $("#modifiers_select").html("<div class='loading'></div>")
      $("#impacted_services_select").html("<div class='loading'></div>")
      # load the inputs originally laoded from the router
      $("#classifications_select").empty()
      DssMessenger.classifications.each (classification) ->
        view = new DssMessenger.Views.Classifications.EditView({model : classification})
        @$("#classifications_select").append(view.render().el)
      @view = new DssMessenger.Views.Classifications.NewView(collection: DssMessenger.classifications)
      $("#classifications_select").append(@view.render().el)

      $("#modifiers_select").empty()
      DssMessenger.modifiers.each (modifier) ->
        view = new DssMessenger.Views.Modifiers.EditView({model : modifier})
        @$("#modifiers_select").append(view.render().el)
      @view = new DssMessenger.Views.Modifiers.NewView(collection: DssMessenger.modifiers)
      $("#modifiers_select").append(@view.render().el)

      $("#impacted_services_select").empty()
      DssMessenger.impacted_services.each (impacted_service) ->
        view = new DssMessenger.Views.impacted_services.EditView({model : impacted_service})
        @$("#impacted_services_select").append(view.render().el)
      @view = new DssMessenger.Views.impacted_services.NewView(collection: DssMessenger.impacted_services)
      $("#impacted_services_select").append(@view.render().el)

    return this
