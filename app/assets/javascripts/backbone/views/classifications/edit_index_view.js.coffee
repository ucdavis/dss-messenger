DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.EditIndexView extends Backbone.View
  template: JST["backbone/templates/classifications/edit_index"]

  initialize: () ->
    DssMessenger.classifications.bind('change', @render)

  addAll: () =>
    DssMessenger.classifications.each(@addOne)

  addOne: (classifications) =>
    view = new DssMessenger.Views.Classifications.EditView({model : classifications})
    @$el.append(view.render().el)

  addNewView: =>
    view = new DssMessenger.Views.Classifications.NewView(collection: DssMessenger.classifications)
    @$el.append(view.render().el)
    
  render: =>
    @$el.html(@template(DssMessenger.classifications.toJSON() ))
    @addAll()
    @addNewView()

    return this

