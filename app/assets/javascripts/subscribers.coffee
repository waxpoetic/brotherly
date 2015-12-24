jQuery ->
  $(document).on 'click', '#dialog .close', (event) ->
    event.preventDefault()
    $('#dialog').foundation 'reveal', 'close'
