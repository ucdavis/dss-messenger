DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.IndexView extends Backbone.View
  template: JST["backbone/templates/modifiers/index"]

  initialize: () ->
    @options.modifiers.bind('reset', @addAll)

  addAll: () =>
    @options.modifiers.each(@addOne)

  addOne: (modifiers) =>
    view = new DssMessenger.Views.Modifiers.ModifiersView({model : modifiers})
    @$("#select_m_filter").append(view.render().el)

  render: =>
    @$el.html(@template(modifiers: @options.modifiers.toJSON() ))
    @addAll()

    return this
