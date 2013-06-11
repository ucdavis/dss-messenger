DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.IndexView extends Backbone.View
  template: JST["backbone/templates/classifications/index"]

  initialize: () ->
    @options.classifications.bind('reset', @addAll)

  addAll: () =>
    @options.classifications.each(@addOne)

  addOne: (classifications) =>
    view = new DssMessenger.Views.Classifications.ClassificationsView({model : classifications})
    @$("#select_c_filter").append(view.render().el)

  render: =>
    @$el.html(@template(classifications: @options.classifications.toJSON() ))
    @addAll()

    return this
