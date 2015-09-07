jQuery ->
  # Populate the results dropdown with new search term results.
  $('.new_search')
    .on 'ajax:success', (event, response) ->
      $('#results').html(response)

  # Autocomplete search query after 3 or more characters have been
  # entered into the field.
  $('.new_search input').on 'keydown', ->
    if $(this).val().length >= 3
      $('.new_search').trigger 'submit.rails'
