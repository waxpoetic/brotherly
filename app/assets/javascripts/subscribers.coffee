$(document).on 'ajax:success', '#new_subscriber_form', (event, response) ->
  $('#dialog').html response
