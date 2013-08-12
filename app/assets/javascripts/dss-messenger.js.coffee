$(document).ready ->
  $('a#about').click ->
    @view = new DssMessenger.Views.Settings.AboutView()
    modal = new Backbone.BootstrapModal(content: @view, title: "About", cancelText: false, okText: "Dismiss").open()

  $('a#prefs').click ->
    @view = new DssMessenger.Views.Settings.PrefsView()
    modal = new Backbone.BootstrapModal(content: @view, title: "Preferences", cancelText: false, okText: "Dismiss").open()
