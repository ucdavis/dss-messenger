DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.FormIndexView extends Backbone.View

  initialize: (options) ->
    @options = options or {}
    DssMessenger.modifiers.bind('change', @render)
    DssMessenger.modifiers.bind('remove', @render)

  addAll: () =>
    DssMessenger.modifiers.each(@addOne)

  addOne: (modifiers) =>
    view = new DssMessenger.Views.Modifiers.FormView({model : modifiers, message: @options.message})
    @$el.append(view.render().el)

  render: =>
    @$el.empty()
    @addAll()

    return this

