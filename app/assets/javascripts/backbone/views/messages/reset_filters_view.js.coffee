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
    DssMessenger.current = 1

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      data:
        page: DssMessenger.current

      success: (messages) =>
        DssMessenger.filterClassification = DssMessenger.filterModifier = DssMessenger.filterService = DssMessenger.filterMevent = 0
        @view = new DssMessenger.Views.Messages.IndexView(messages: @messages)
        $("#messages").html(@view.render().el)
        $('#reset-filters').addClass('hidden')

      error: (messages, response) ->
        console.log "#{response.status}."
        $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
    return false

