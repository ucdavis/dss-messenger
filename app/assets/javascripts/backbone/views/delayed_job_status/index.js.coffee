DssMessenger.Views.DelayedJobStatus||= {}

class DssMessenger.Views.DelayedJobStatus.IndexView extends Backbone.View
  template: JST["backbone/templates/delayed_job_status/index"]

  render: ->
    ((self) ->
      $.ajax(
        url: '/delayed_job_status'
        type: 'get'
        success: (data) ->
          self.status = data
          self.$el.html(self.template({status: self.status}))
      ).fail( ->
        self.status = false
        self.$el.html(self.template({status: self.status}))
    ))(this)

    return this
