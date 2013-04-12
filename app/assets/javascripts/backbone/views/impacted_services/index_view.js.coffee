DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.IndexView extends Backbone.View
  template: JST["backbone/templates/impacted_services/index"]

  initialize: () ->
    @options.impacted_services.bind('reset', @addAll)

  addAll: () =>
    @options.impacted_services.each(@addOne)

  addOne: (impacted_services) =>
    view = new DssMessenger.Views.impacted_services.impacted_servicesView({model : impacted_services})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(impacted_services: @options.impacted_services.toJSON() ))
    @addAll()

    return this
