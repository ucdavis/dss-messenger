DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.messenger_eventsView extends Backbone.View
  template: JST["backbone/templates/messenger_events/messenger_events"]

  events:
    "click"          : "filter"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this

  filter: (e) ->
    e.stopPropagation()
    selected_id = this.model.get('id')
    $('#reset-filters').removeClass('hidden')

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        me: selected_id

      success: (messages, a, b, c) =>
        @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
        $("#messages").html(@view.render().el)

      error: (messages, response) ->
        console.log "#{response.status}."
    return true
