DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.IndexView extends Backbone.View
  template: JST["backbone/templates/impacted_services/index"]

  tagName: "select"

  events:
    "change"          : "filter"
  
  initialize: () ->
    @options.impacted_services.bind('reset', @addAll)
    _.defer =>
      $('.selectpicker').selectpicker()

  addAll: () =>
    @$el.append('<option value="">Impacted Services</option>')
    @options.impacted_services.each(@addOne)

  addOne: (impacted_services) =>
    view = new DssMessenger.Views.impacted_services.impacted_servicesView({model : impacted_services})
    @$el.append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(impacted_services: @options.impacted_services.toJSON() ))
    @addAll()

    return this

  filter: (e) ->
    e.stopPropagation()
    service = @$el.val()
    if service != ''
      classification = $("input[name='cl_filter[]']:checked").val()
      modifier = $("input[name='mo_filter[]']:checked").val()
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

