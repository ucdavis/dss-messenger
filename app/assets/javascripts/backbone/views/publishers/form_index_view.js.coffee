DssMessenger.Views.Publishers ||= {}

class DssMessenger.Views.Publishers.FormIndexView extends Backbone.View

  initialize: (options) ->
    @options = options or {}
    DssMessenger.publishers.bind('change', @render)
    DssMessenger.publishers.bind('remove', @render)

  addAll: () =>
    DssMessenger.publishers.each(@addOne)

  addOne: (publisher) =>
    view = new DssMessenger.Views.Publishers.FormView({model : publisher, message: @options.message})
    @$el.append(view.render().el)

  render: =>
    @$el.empty()
    @addAll()

    return this

