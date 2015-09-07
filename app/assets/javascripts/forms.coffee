jQuery ->
  # Handle form response messages in a consistent way. Any flash
  # messages are populated into the headers of every response, used for
  # when Ajax requests are sending back response data to the front-end.
  # This JavaScript is responsible for populating the front-end with the
  # new flash messages, using our `FlashMessage` object.
  $('form')
    .on 'ajax:error', (xhr, status, error) ->
      flash.alert error
    .on 'ajax:complete', (event, xhr) ->
      flash.notice xhr.getResponseHeader('X-Flash-Notice')
      flash.alert xhr.getResponseHeader('X-Flash-Alert')
