DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.FormIndexView extends Backbone.View

  initialize: () ->
    DssMessenger.classifications.bind('change', @render)
    DssMessenger.classifications.bind('remove', @render)

  addAll: () =>
    DssMessenger.classifications.each(@addOne)

  addOne: (classifications) =>
    view = new DssMessenger.Views.Classifications.FormView({model : classifications, message: @options.message})
    @$el.append(view.render().el)

  render: =>
    @$el.empty()
    @addAll()

    return this

