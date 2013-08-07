DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.EditIndexView extends Backbone.View
  template: JST["backbone/templates/modifiers/edit_index"]

  initialize: () ->
    DssMessenger.modifiers.bind('change', @render)

  addAll: () =>
    DssMessenger.modifiers.each(@addOne)

  addOne: (modifiers) =>
    view = new DssMessenger.Views.Modifiers.EditView({model : modifiers})
    @$el.append(view.render().el)

  addNewView: =>
    view = new DssMessenger.Views.Modifiers.NewView(collection: DssMessenger.modifiers)
    @$el.append(view.render().el)
    
  render: =>
    @$el.html(@template(DssMessenger.modifiers.toJSON() ))
    @addAll()
    @addNewView()

    return this

