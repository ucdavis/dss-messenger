class DssMessenger.Routers.ClassificationsRouter extends Backbone.Router
  initialize: (options) ->
    @classifications = new DssMessenger.Collections.ClassificationsCollection()
    @classifications.reset options.classifications

  routes:
    "new"      : "newClassifications"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newClassifications: ->
    @view = new DssMessenger.Views.Classifications.NewView(collection: @classifications)
    $("#classifications").html(@view.render().el)

  index: ->
    @view = new DssMessenger.Views.Classifications.IndexView(classifications: @classifications)
    $("#classifications").html(@view.render().el)

  show: (id) ->
    classifications = @classifications.get(id)

    @view = new DssMessenger.Views.Classifications.ShowView(model: classifications)
    $("#classifications").html(@view.render().el)

  edit: (id) ->
    classifications = @classifications.get(id)

    @view = new DssMessenger.Views.Classifications.EditView(model: classifications)
    $("#classifications").html(@view.render().el)
