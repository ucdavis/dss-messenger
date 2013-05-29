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
    classification = $("input[name='cl_filter[]']:checked").val()
    modifier = $("input[name='mo_filter[]']:checked").val()
    service = this.model.get('id')
    mevent = $("input[name='me_filter[]']:checked").val()

    $("#messages").append("<div class='overlay'><div class='loading'></div></div>")

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        cl: classification
        mo: modifier
        is: service
        me: mevent

      success: (messages) =>
        @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
        $("#messages").html(@view.render().el)
	    $('#reset-filters').removeClass('hidden')

      error: (messages, response) ->
        console.log "#{response.status}."
        $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
    return true
	
  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
