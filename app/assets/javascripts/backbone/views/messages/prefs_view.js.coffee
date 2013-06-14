DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.PrefsView extends Backbone.View
  template: JST["backbone/templates/messages/prefs"]

  initialize: ->
    _.defer =>
      $("#classifications_select").html("<div class='loading'></div>")
      $("#modifiers_select").html("<div class='loading'></div>")
      $("#impacted_services_select").html("<div class='loading'></div>")

    @classifications = new DssMessenger.Collections.ClassificationsCollection()
    @classifications.fetch	

      success: (classifications) ->
        $("#classifications_select").empty()
        classifications.each (classification) ->
          view = new DssMessenger.Views.Classifications.EditView({model : classification})
          @$("#classifications_select").append(view.render().el)
        @view = new DssMessenger.Views.Classifications.NewView(collection: classifications)
        $("#classifications_select").append(@view.render().el)

      error: (classifications, response) ->
        $("#classifications_select").html("<div class='error'></div>")
        console.log "#{response.status}."

    @modifiers = new DssMessenger.Collections.ModifiersCollection()
    @modifiers.fetch	

      success: (modifiers) ->
        $("#modifiers_select").empty()
        modifiers.each (modifier) ->
          view = new DssMessenger.Views.Modifiers.EditView({model : modifier})
          @$("#modifiers_select").append(view.render().el)
        @view = new DssMessenger.Views.Modifiers.NewView(collection: modifiers)
        $("#modifiers_select").append(@view.render().el)

      error: (modifiers, response) ->
        $("#modifiers_select").html("<div class='error'></div>")
        console.log "#{response.status}."

    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch

      success: (impacted_services) ->
        $("#impacted_services_select").empty()
        impacted_services.each (impacted_service) ->
          view = new DssMessenger.Views.impacted_services.EditView({model : impacted_service})
          @$("#impacted_services_select").append(view.render().el)
        @view = new DssMessenger.Views.impacted_services.NewView(collection: impacted_services)
        $("#impacted_services_select").append(@view.render().el)

      error: (impacted_services, response) ->
        $("#impacted_services_select").html("<div class='error'></div>")
        console.log "#{response.status}."


  render: ->
    console.log 'rendering preferences'
    @$el.html(@template( ))

    return this
