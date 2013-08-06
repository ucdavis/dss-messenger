$(document).ready ->
  $('a#about').click ->
    @view = new DssMessenger.Views.Settings.AboutView()
    modal = new Backbone.BootstrapModal(content: @view, title: "About").open()
