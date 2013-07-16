class DssMessenger.Views.Messages.ResetFiltersView extends Backbone.View

  events:
    "click #reset-filters" : "reset"
  
  render: =>
    @$el.html('<a href="#" id="reset-filters" class="btn hidden">Reset Filters</a>')

    return this

  reset: (e) ->
    e.stopPropagation()
    $('#filters-form select').each -> $(this).selectpicker 'val', 0
    $("#messages").append("<div class='overlay'><div class='loading'></div></div>")

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch

      success: (messages) =>
        if @messages.length > 0
          DssMessenger.pages = @messages.first().get('pages')
          DssMessenger.current = @messages.first().get('current')
        else
          DssMessenger.pages = 0
          DssMessenger.current = 0
          
        $('#reset-filters').addClass('hidden')

      error: (messages, response) ->
        console.log "#{response.status}."
        $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
    return false

