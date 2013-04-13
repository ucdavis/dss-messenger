class DssMessenger.Routers.DsseventsRouter extends Backbone.Router
  initialize: (options) ->
    @dssevents = new DssMessenger.Collections.DsseventsCollection()
    @dssevents.reset options.dssevents

  routes:
    "new"      : "newDssevents"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newDssevents: ->
    @view = new DssMessenger.Views.Dssevents.NewView(collection: @dssevents)
    $("#dssevents").html(@view.render().el)

  index: ->
    @view = new DssMessenger.Views.Dssevents.IndexView(dssevents: @dssevents)
    $("#dssevents").html(@view.render().el)

  show: (id) ->
    dssevents = @dssevents.get(id)

    @view = new DssMessenger.Views.Dssevents.ShowView(model: dssevents)
    $("#dssevents").html(@view.render().el)

  edit: (id) ->
    dssevents = @dssevents.get(id)

    @view = new DssMessenger.Views.Dssevents.EditView(model: dssevents)
    $("#dssevents").html(@view.render().el)
