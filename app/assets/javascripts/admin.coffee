# Handle Rails UJS functionality on the admin level in a consistent way.
# Forms are always shown in the `#editor` panel, and submit by
# refreshing only the `<main>` tag, which includes a fresh editor, new
# table data and flash messaging. Destroy actions fade out the `<tr>`
# that surrounds them and populate a flash message from the header.
jQuery ->
  $(document)
    .on 'ajax:error', '#admin a, #admin form', (event, status, error) ->
      flash.alert error
    .on 'ajax:success', '#admin .edit a, #admin .new a', (event, response) ->
      $('#editor').html(response)
    .on 'ajax:success', '#admin .destroy a', (event, response, xhr) ->
      flash.alert xhr.getResponseHeader('X-Flash-Notice')
      $(this).closest('tr').fadeOut(250)
    .on 'ajax:success', '#admin form', (event, response) ->
      $('#admin main').html(response)
    .on 'ajax:complete', '#admin a, #admin form', (event, xhr) ->
      flash.alert xhr.getResponseHeader('X-Flash-Notice')

