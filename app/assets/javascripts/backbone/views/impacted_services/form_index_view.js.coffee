DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.FormIndexView extends Backbone.View

  initialize: (options) ->
    @options = options
    DssMessenger.impacted_services.bind('change', @render)
    DssMessenger.impacted_services.bind('remove', @render)

  addAll: () =>
    DssMessenger.impacted_services.each(@addOne)

  addOne: (impacted_services) =>
    view = new DssMessenger.Views.impacted_services.FormView({model : impacted_services, message: @options.message})
    @$el.append(view.render().el)

  render: =>
    @$el.empty()
    @addAll()

    return this

