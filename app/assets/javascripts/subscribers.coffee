$(document).ready ->
  $('#dialog form').on 'ajax:success', (event, response) ->
    $('#dialog').html response
