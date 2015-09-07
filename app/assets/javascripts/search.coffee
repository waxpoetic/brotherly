jQuery ->
  $('.new_search')
    .on 'ajax:success', (event, response) -> $('#results').html(response)
    .on 'ajax:error', (xhr, status, error) -> alert error

  $('.new_search input').on 'keydown', ->
    if $(this).val().length >= 3
      $('.new_search').trigger 'submit.rails'
