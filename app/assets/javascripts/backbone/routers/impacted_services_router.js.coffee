class DssMessenger.Routers.impacted_servicesRouter extends Backbone.Router
  initialize: (options) ->
    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.reset options.impacted_services

  routes:
    "new"      : "newimpacted_services"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newimpacted_services: ->
    @view = new DssMessenger.Views.impacted_services.NewView(collection: @impacted_services)
    $("#impacted_services").html(@view.render().el)

  index: ->
    @view = new DssMessenger.Views.impacted_services.IndexView(impacted_services: @impacted_services)
    $("#impacted_services").html(@view.render().el)

  show: (id) ->
    impacted_services = @impacted_services.get(id)

    @view = new DssMessenger.Views.impacted_services.ShowView(model: impacted_services)
    $("#impacted_services").html(@view.render().el)

  edit: (id) ->
    impacted_services = @impacted_services.get(id)

    @view = new DssMessenger.Views.impacted_services.EditView(model: impacted_services)
    $("#impacted_services").html(@view.render().el)
