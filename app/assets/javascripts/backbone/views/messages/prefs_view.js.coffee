DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.PrefsView extends Backbone.View
  template: JST["backbone/templates/messages/prefs"]

  initialize: ->
    _.defer =>
      $("#classifications_select").html("<div class='loading'></div>")
      $("#modifiers_select").html("<div class='loading'></div>")
      $("#impacted_services_select").html("<div class='loading'></div>")

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


  render: ->
    console.log 'rendering preferences'
    @$el.html(@template( ))

    return this
