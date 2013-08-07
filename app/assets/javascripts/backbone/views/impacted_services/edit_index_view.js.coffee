DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.EditIndexView extends Backbone.View
  template: JST["backbone/templates/impacted_services/edit_index"]

  initialize: () ->
    DssMessenger.impacted_services.bind('change', @render)

  addAll: () =>
    DssMessenger.impacted_services.each(@addOne)

  addOne: (impacted_services) =>
    view = new DssMessenger.Views.impacted_services.EditView({model : impacted_services})
    @$el.append(view.render().el)

  addNewView: =>
    view = new DssMessenger.Views.impacted_services.NewView(collection: DssMessenger.impacted_services)
    @$el.append(view.render().el)
    
  render: =>
    @$el.html(@template(DssMessenger.impacted_services.toJSON() ))
    @addAll()
    @addNewView()

    return this

