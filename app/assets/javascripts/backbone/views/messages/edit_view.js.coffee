DssMessenger.Views.Messages ||= {}

class DssMessenger.Views.Messages.EditView extends Backbone.View
  template: JST["backbone/templates/messages/edit"]

  events:
    "submit #edit-message": "update"
    "focus .datepicker"	:	"displayPicker"
    "focus #Recipients"	:	"tokenInput"

  initialize: ->
    $("input[name=Recipients]").tokenInput "http://shell.loopj.com/tokeninput/tvshows.php",
      theme: "facebook" #WHY NO SHOW!
    @current_classification = @model.get('classification_id')
    @classifications = new DssMessenger.Collections.ClassificationsCollection()
    @classifications.fetch	

      success: (classifications) =>
        classifications.each (classification) =>
          @checked = @current_classification is classification.get('id')
          $("#classifications_select").append "<label class='radio'><input type='radio' name='classification_id[]' value='" + classification.get('id') + (if @checked then "' checked />" else "' />") + classification.get('description') + "</label>"

      error: (classifications, response) ->
        console.log "#{response.status}."

    @current_modifier = @model.get('modifier_id')
    @modifiers = new DssMessenger.Collections.ModifiersCollection()
    @modifiers.fetch	

      success: (modifiers) =>
        modifiers.each (modifier) =>
          @checked = @current_modifier is modifier.get('id')
          $("#modifiers_select").append "<label class='radio'><input type='radio' name='modifier_id[]' value='" + modifier.get('id') + (if @checked then "' checked />" else "' />") + modifier.get('description') + "</label>"

      error: (modifiers, response) ->
        console.log "#{response.status}."

    @current_services = @model.get('impacted_services')
    @impacted_services = new DssMessenger.Collections.impacted_servicesCollection()
    @impacted_services.fetch	

      success: (impacted_services) =>
        impacted_services.each (impacted_service) =>
          @checked = _.find @current_services, (current_service) =>
            return current_service.id is impacted_service.get('id')
          $("#impacted_services_select").append "<label class='checkbox'><input type='checkbox' name='impacted_service_ids[]' value='" + impacted_service.get('id') + (if @checked then "' checked />" else "' />") + impacted_service.get('name') + "</label>"

      error: (impacted_services, response) ->
        console.log "#{response.status}."

    @current_events = @model.get('messenger_events')
    @messenger_events = new DssMessenger.Collections.messenger_eventsCollection()
    @messenger_events.fetch	

      success: (messenger_events) =>
        messenger_events.each (messenger_event) =>
          @checked = _.find @current_events, (current_event) =>
            return current_event.id is messenger_event.get('id')
          $("#messenger_events_select").append "<label class='checkbox'><input type='checkbox' name='messenger_event_ids[]' value='" + messenger_event.get('id') + (if @checked then "' checked />" else "' />") + messenger_event.get('description') + "</label>"

      error: (messenger_events, response) ->
        console.log "#{response.status}."


  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @picked_impacted_services = _.filter(@impacted_services.models, (a) ->
        _.contains(_.map($("input[name='impacted_service_ids[]']:checked"), (a) -> parseInt a.value ), a.get('id'))
    )
    @picked_messenger_events = _.filter(@messenger_events.models, (a) ->
        _.contains(_.map($("input[name='messenger_event_ids[]']:checked"), (a) -> parseInt a.value ), a.get('id'))
    )
    
    @model.set
      recipient_ids: _.map($("input[name='recipient_ids[]']:checked"), (a) -> a.value )
      impacted_service_ids: _.map($("input[name='impacted_service_ids[]']:checked"), (a) -> a.value )
      messenger_event_ids: _.map($("input[name='messenger_event_ids[]']:checked"), (a) -> a.value )
      recipients: @picked_recipients
      impacted_services: @picked_impacted_services
      messenger_events: @picked_messenger_events
      classification_id: $("input[name='classification_id[]']:checked").val()
      modifier_id: $("input[name='modifier_id[]']:checked").val()

    @model.save(null,
      success: (message) =>
        @model = message
        window.location.hash = "#/index"
    )

  displayPicker: (e) ->
    $('.datepicker').datetimepicker()

  tokenInput: (e) ->
    $("input[name=recipient_ids]").tokenInput "/recipients",
      theme: "facebook"
      onAdd: (item) =>
        @model.recipients.add {uid: item.id}
        console.log @model

      onDelete: (item) =>
        console.log @model


  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
