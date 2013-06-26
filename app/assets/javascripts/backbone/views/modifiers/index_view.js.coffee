DssMessenger.Views.Modifiers ||= {}

class DssMessenger.Views.Modifiers.IndexView extends Backbone.View
  template: JST["backbone/templates/modifiers/index"]

  tagName: "select"

  events:
    "change"          : "filter"
  
  initialize: () ->
    @options.modifiers.bind('reset', @addAll)
    _.defer =>
      $('.selectpicker').selectpicker()

  addAll: () =>
    @$el.append('<option value="">Modifiers</option>')
    @options.modifiers.each(@addOne)

  addOne: (modifiers) =>
    view = new DssMessenger.Views.Modifiers.ModifiersView({model : modifiers})
    @$el.append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(modifiers: @options.modifiers.toJSON() ))
    @addAll()

    return this

  filter: (e) ->
    e.stopPropagation()
    modifier = @$el.val()
    if modifier != ''
      classification = $("input[name='cl_filter[]']:checked").val()
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
          $('#reset-filters').removeClass('hidden')

        error: (messages, response) ->
          console.log "#{response.status}."
          $("#messages").append("<div class='overlay'><div class='error'>Loading Error</div></div>")
      return true

