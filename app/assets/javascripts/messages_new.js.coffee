# Initialize the date-time picker fields
$("input.datetimepicker").datetimepicker
  format: "yyyy/mm/dd HH:ii P"
  minuteStep: 30
  autoclose: true
  todayBtn: true
  todayHighlight: true
  showMeridian: true
  pickerPosition: "bottom-left"

# Initialize the recipients typeahead field
recipientList = new Bloodhound
  datumTokenizer: (d) ->
    debugger
    Bloodhound.tokenizers.obj.whitespace('value')
  queryTokenizer: Bloodhound.tokenizers.whitespace
  remote:
    url: Routes.recipients_path() + '.json?q=%QUERY'
    wildcard: '%QUERY'

recipientList.initialize()

$('input.typeahead').tokenfield({
  typeahead: [null, { source: recipientList.ttAdapter(), displayKey: 'value' }]
});
