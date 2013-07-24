DssMessenger.Views.messenger_events ||= {}

class DssMessenger.Views.messenger_events.IndexView extends Backbone.View
  template: JST["backbone/templates/messenger_events/index"]

  tagName: "select"

  events:
    "change"          : "filter"

  initialize: () ->
    @options.messenger_events.bind('reset', @addAll)
    _.defer =>
      @$el.selectpicker()
      @$el.selectpicker 'val', DssMessenger.filterMevent if DssMessenger.filterMevent > 0

  addAll: () =>
    @$el.append('<option></option>')
    @options.messenger_events.each(@addOne)

  addOne: (messenger_events) =>
    view = new DssMessenger.Views.messenger_events.messenger_eventsView({model : messenger_events})
    @$el.append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(DssMessenger.messenger_events.toJSON() ))
    @addAll()

    return this

  filter: (e) ->
    e.stopPropagation()
    if @$el.val() > 0
      DssMessenger.filterMevent = @$el.val()
      DssMessenger.current = 1

      $('.overlay,.loading').removeClass('hidden')

      DssMessenger.messages.fetch
        timeout: 30000 # 30 seconds
        data:
          page: DssMessenger.current,
          cl: DssMessenger.filterClassification if DssMessenger.filterClassification > 0,
          mo: DssMessenger.filterModifier if DssMessenger.filterModifier > 0,
          is: DssMessenger.filterService if DssMessenger.filterService > 0,
          me: DssMessenger.filterMevent if DssMessenger.filterMevent > 0

        success: (messages, a, b, c) =>
          if messages.length > 0
            DssMessenger.pages = messages.first().get('pages')
            DssMessenger.current = messages.first().get('current')
          else
            DssMessenger.pages = 1
            DssMessenger.current = 1
          
          $('#reset-filters').removeClass('hidden')

        error: (messages, response) ->
          console.log "#{response.status}."
          $('.error').removeClass('hidden')

      return true
