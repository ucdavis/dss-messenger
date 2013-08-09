DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.IndexView extends Backbone.View
  template: JST["backbone/templates/impacted_services/index"]

  tagName: "select"

  events:
    "change"          : "filter"
  
  initialize: () ->
    DssMessenger.impacted_services.bind('reset', @addAll)
    _.defer =>
      @$el.selectpicker()
      @$el.selectpicker 'val', DssMessenger.filterService if DssMessenger.filterService > 0

  addAll: () =>
    @$el.append('<option></option>')
    DssMessenger.impacted_services.each(@addOne)

  addOne: (impacted_services) =>
    view = new DssMessenger.Views.impacted_services.impacted_servicesView({model : impacted_services})
    @$el.append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(DssMessenger.impacted_services.toJSON() ))
    @addAll()

    return this

  filter: (e) ->
    e.stopPropagation()
    DssMessenger.filterService = Number @$el.val()
    DssMessenger.current = 1

    $('.overlay,.loading').removeClass('hidden')

    DssMessenger.messages.fetch
      timeout: 30000 # 30 seconds
      data:
        page: DssMessenger.current,
        cl: DssMessenger.filterClassification if DssMessenger.filterClassification > 0,
        mo: DssMessenger.filterModifier if DssMessenger.filterModifier > 0,
        is: DssMessenger.filterService if DssMessenger.filterService > 0,

      success: (messages) =>
        if messages.length > 0
          DssMessenger.pages = messages.first().get('pages')
          DssMessenger.current = messages.first().get('current')
        else
          DssMessenger.pages = 1
          DssMessenger.current = 1
        
        if DssMessenger.filterClassification == DssMessenger.filterModifier == DssMessenger.filterService
          $("#reset-filters").addClass("hidden")
        else
          $("#reset-filters").removeClass("hidden")

      error: (messages, response) ->
        console.log "#{response.status}."
        $('.error').removeClass('hidden')

    return true

