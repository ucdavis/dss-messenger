# Configure Turbolinks
Turbolinks.enableProgressBar()

# Configure toastr (displays flash messages)
toastr.options =
  "closeButton": false
  "debug": false
  "newestOnTop": false
  "progressBar": false
  "positionClass": "toast-bottom-center"
  "preventDuplicates": false
  "onclick": null
  "showDuration": "300"
  "hideDuration": "1000"
  "timeOut": "3000"
  "extendedTimeOut": "1000"
  "showEasing": "swing"
  "hideEasing": "linear"
  "showMethod": "fadeIn"
  "hideMethod": "fadeOut"

$(document).ready () ->
  # Configure site-wide message search
  messageList = new Bloodhound
    datumTokenizer: Bloodhound.tokenizers.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    limit: 8
    remote:
      url: Routes.messages_path() + '.json?q=%QUERY'
      wildcard: '%QUERY'

  messageList.initialize()

  $('#message_search').typeahead(null,
    displayKey: 'label'
    source: messageList.ttAdapter()
  )
