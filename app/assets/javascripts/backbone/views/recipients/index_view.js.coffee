DssMessenger.Views.Recipients ||= {}

class DssMessenger.Views.Recipients.IndexView extends Backbone.View
  template: JST["backbone/templates/recipients/index"]

  initialize: () ->
    @options.recipients.bind('reset', @addAll)

  addAll: () =>
    @options.recipients.each(@addOne)

  addOne: (recipient) =>
    view = new DssMessenger.Views.Recipients.RecipientView({model : recipient})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(recipients: @options.recipients.toJSON() ))
    @addAll()

    return this
