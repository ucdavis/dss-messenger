class DssMessenger.Routers.ModifiersRouter extends Backbone.Router
  initialize: (options) ->
    @modifiers = new DssMessenger.Collections.ModifiersCollection()
    @modifiers.reset options.modifiers

  routes:
    "new"      : "newModifiers"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newModifiers: ->
    @view = new DssMessenger.Views.Modifiers.NewView(collection: @modifiers)
    $("#modifiers").html(@view.render().el)

  index: ->
    @view = new DssMessenger.Views.Modifiers.IndexView(modifiers: @modifiers)
    $("#modifiers").html(@view.render().el)

  show: (id) ->
    modifiers = @modifiers.get(id)

    @view = new DssMessenger.Views.Modifiers.ShowView(model: modifiers)
    $("#modifiers").html(@view.render().el)

  edit: (id) ->
    modifiers = @modifiers.get(id)

    @view = new DssMessenger.Views.Modifiers.EditView(model: modifiers)
    $("#modifiers").html(@view.render().el)
