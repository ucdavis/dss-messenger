class DssMessenger.Views.Messages.ResetFiltersView extends Backbone.View

  events:
    "click #reset-filters" : "reset"
  
  render: =>
    @$el.html('<a href="#" id="reset-filters" class="btn hidden">Reset Filters</a>')

    return this

  reset: (e) ->
    e.stopPropagation()
    $('#filters-form select').each -> $(this).selectpicker 'val', 0
    DssMessenger.current = 1

    $('.overlay,.loading').removeClass('hidden')

    DssMessenger.messages.fetch
      timeout: 30000 # 30 seconds
      data:
        page: DssMessenger.current

      success: (messages) =>
        if messages.length > 0
          DssMessenger.pages = messages.first().get('pages')
          DssMessenger.current = messages.first().get('current')
        else
          DssMessenger.pages = 1
          DssMessenger.current = 1

        DssMessenger.filterClassification = DssMessenger.filterModifier = DssMessenger.filterService = DssMessenger.filterMevent = 0
        $('#reset-filters').addClass('hidden')

      error: (messages, response) ->
        console.log "#{response.status}."
        $('.error').removeClass('hidden')
    return false

