jQuery ->
  # Populate the results dropdown with new search term results.
  showResults = (event, response) ->
    $('#search .results').html(response).slideDown(250)
  $('#search form')
    .on 'ajax:before', ->
      $('#search .results').text("Searching...").show()
    .on 'ajax:success', showResults

  # Autocomplete search query by submitting the form.
  submitForm = ->
    $('#search form').trigger 'submit.rails'
  $('#search form input').on 'keydown', _.debounce(submitForm, 350)
