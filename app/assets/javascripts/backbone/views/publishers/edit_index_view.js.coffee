DssMessenger.Views.Publishers ||= {}

class DssMessenger.Views.Publishers.EditIndexView extends Backbone.View
  template: JST["backbone/templates/publishers/edit_index"]

  initialize: () ->
    DssMessenger.publishers.bind('change', @render)

  addAll: () =>
    DssMessenger.publishers.each(@addOne)

  addOne: (publisher) =>
    view = new DssMessenger.Views.Publishers.EditView({model : publisher })
    @$("#edit_publishers").append(view.render().el)

  render: =>
    @$el.html(@template(DssMessenger.publishers.toJSON() ))
    @addAll()

    return this

