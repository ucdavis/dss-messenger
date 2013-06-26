DssMessenger.Views.Classifications ||= {}

class DssMessenger.Views.Classifications.IndexView extends Backbone.View
  template: JST["backbone/templates/classifications/index"]

  events:
    "change"          : "filter"

  tagName: "select"
  
  initialize: () ->
    @options.classifications.bind('reset', @addAll)
    _.defer =>
      $('.selectpicker').selectpicker()

  addAll: () =>
    @$el.append('<option value="">Classifications</option>')
    @options.classifications.each(@addOne)

  addOne: (classifications) =>
    view = new DssMessenger.Views.Classifications.ClassificationsView({model : classifications})
    @$el.append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(classifications: @options.classifications.toJSON() ))
    @addAll()

    return this

  filter: (e) ->
    e.stopPropagation()
    classification = @$el.val()
    if classification != ''
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
          $("#reset-filters").removeClass("hidden")

        error: (messages, response) ->
          console.log "#{response.status}."
          $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
      return true
