DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.PrefsView extends Backbone.View
  template: JST["backbone/templates/messages/prefs"]


  render: ->
    console.log 'rendering preferences'
    @$el.html(@template( ))

    return this
