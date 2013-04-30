DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.impacted_servicesView extends Backbone.View
  template: JST["backbone/templates/impacted_services/impacted_services"]

  events:
    "click"          : "filter"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  filter: (e) ->
    e.stopPropagation()
    selected_id = this.model.get('id')
    $('#reset-filters').removeClass('hidden')

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        is: selected_id

      success: (messages) =>
        @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
        $("#messages").html(@view.render().el)

      error: (messages, response) ->
        console.log "#{response.status}."
    return true
	
  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
