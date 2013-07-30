DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.IndexView extends Backbone.View
  template: JST["backbone/templates/messages/index"]

  events:
    "click .more" : "getMore"

  initialize: () ->
    DssMessenger.messages.bind('reset', @render)
    DssMessenger.messages.bind('add', @addOne)
    
  addAll: () =>
    DssMessenger.messages.each(@addOne)

    _.defer =>
      # this will un-hide the 'show more' button if there is more messages
      $(".pagination").removeClass('hidden') if DssMessenger.current < DssMessenger.pages
      # this will affix the table header when scrolled
      $("#mtable-head").affix offset: $("#messages-table").position().top - 40
      $("#mtable-head th").each ->
        $(this).width $(this).width()

  getMore: (e) =>
    e.preventDefault()
    e.stopPropagation()

    $(".pagination").fadeOut() if ++DssMessenger.current >= DssMessenger.pages
    $(".pagination a").removeClass('more').html('loading...')

    @messages = new DssMessenger.Collections.MessagesCollection()
    @messages.fetch
      timeout: 30000 # 30 seconds
      data:
        page: DssMessenger.current,
        cl: DssMessenger.filterClassification if DssMessenger.filterClassification > 0,
        mo: DssMessenger.filterModifier if DssMessenger.filterModifier > 0,
        is: DssMessenger.filterService if DssMessenger.filterService > 0,

      success: (messages) =>
        DssMessenger.messages.add(messages.models)
        $(".pagination a").addClass('more').html('Show more')

      error: (messages, response) ->
        console.log "#{response.status}."
        $(".pagination a").addClass('text-error').html('Error loading')
    
  addOne: (message) =>
    view = new DssMessenger.Views.Messages.MessageView({model : message})
    @$("tbody").append(view.render().el)

  render: =>
    window.scrollTo 0, 0
    $('.overlay,.loading,.error').addClass('hidden')
    @$el.html(@template(messages: DssMessenger.messages.toJSON() ))
    @addAll()

    _.defer =>
      #Hide the table and display "No Messages" if the collection is empty
      if DssMessenger.messages.size() is 0
        $("#messages-table, .pagination").hide()
        @$el.html('<h2 class="text-center">No Messages</h2>')


    return this
