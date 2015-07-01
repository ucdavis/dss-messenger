DssMessenger.Views.DelayedJobStatus||= {}

class DssMessenger.Views.DelayedJobStatus.IndexView extends Backbone.View
  template: JST["backbone/templates/delayed_job_status/index"]

  initialize: ->
    $.get('/delayed_job_status', () ->
      @status = true
    ).fail(() ->
      @status = false
    )

  render: ->
    @$el.html(@template())

    return this
