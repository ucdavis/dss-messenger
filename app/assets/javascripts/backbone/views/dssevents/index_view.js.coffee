DssMessenger.Views.Dssevents ||= {}

class DssMessenger.Views.Dssevents.IndexView extends Backbone.View
  template: JST["backbone/templates/dssevents/index"]

  initialize: () ->
    @options.dssevents.bind('reset', @addAll)

  addAll: () =>
    @options.dssevents.each(@addOne)

  addOne: (dssevents) =>
    view = new DssMessenger.Views.Dssevents.DsseventsView({model : dssevents})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(dssevents: @options.dssevents.toJSON() ))
    @addAll()

    return this
