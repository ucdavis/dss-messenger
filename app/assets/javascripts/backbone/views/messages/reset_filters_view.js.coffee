class DssMessenger.Views.Messages.ResetFiltersView extends Backbone.View

  events:
    "click #reset-filters" : "reset"
  
  render: =>
    console.log "rendering reset filters"
    @$el.html('<a href="#/index" id="reset-filters" class="btn hidden">Reset Filters</a>')

    return this

  reset: (e) ->
    e.stopPropagation()
    $('#filters-form select').each -> $(this).selectpicker 'val', 0
    $("#messages").append("<div class='overlay'><div class='loading'></div></div>")

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch

      success: (messages) =>
        @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
        $("#messages").html(@view.render().el)
        $('#reset-filters').addClass('hidden')

      error: (messages, response) ->
        console.log "#{response.status}."
        $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
    return false

