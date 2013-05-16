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
    selected_id = this.model.get('id')
    $("#messages").append("<div class='overlay'><div class='loading'></div></div>")

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        cl: selected_id

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
