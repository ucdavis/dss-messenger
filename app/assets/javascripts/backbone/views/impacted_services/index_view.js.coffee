DssMessenger.Views.impacted_services ||= {}

class DssMessenger.Views.impacted_services.IndexView extends Backbone.View
  template: JST["backbone/templates/impacted_services/index"]

  tagName: "select"
  
  initialize: () ->
    @options.impacted_services.bind('reset', @addAll)
    _.defer =>
      $('.selectpicker').selectpicker()

  addAll: () =>
    @$el.append('<option value="">Impacted Services</option>')
    @options.impacted_services.each(@addOne)

  addOne: (impacted_services) =>
    view = new DssMessenger.Views.impacted_services.impacted_servicesView({model : impacted_services})
    @$("#select_is_filter").append(view.render().el)

  render: =>
    @$el.addClass('selectpicker').html(@template(impacted_services: @options.impacted_services.toJSON() ))
    @addAll()

    return this
