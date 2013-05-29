DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.ClassificationsView extends Backbone.View
  template: JST["backbone/templates/classifications/classifications"]

  events:
    "click"          : "filter"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  filter: (e) ->
    e.stopPropagation()
    classification = this.model.get('id')
    modifier = $("input[name='mo_filter[]']:checked").val()
    service = $("input[name='is_filter[]']:checked").val()
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
