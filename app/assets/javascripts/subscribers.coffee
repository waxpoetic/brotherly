jQuery ->
  $(document).on 'click', '#dialog .close', (event) ->
    event.preventDefault()
    $('#dialog').foundation 'reveal', 'close'

  $(document).on 'ajax:success', '#new_subscriber', (event, response) ->
    debugger
    $('#dialog').html(response)
