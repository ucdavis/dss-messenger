DssMessenger.Views.Settings ||= {}

class DssMessenger.Views.Settings.AboutView extends Backbone.View
  template: JST["backbone/templates/settings/about"]

  initialize: ->
    @bind("cancel", @removeFromDOM)

  removeFromDOM: (modal) ->
    modal.remove()

  render: ->
    @$el.html(@template())

    _.defer =>
      $("span#last_updated").html DssMessenger.last_updated

    return this
