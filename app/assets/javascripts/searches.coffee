jQuery ->
  # Populate the results dropdown with new search term results, and show
  # an interstitial message while waiting for responses.
  $('#search form')
    .on 'ajax:before', ->
      $('#search .results')
        .css('clip', 'auto')
        .html('<li><label>Searching...</label></li>')
        .show()
    .on 'ajax:success', (event, response) ->
      $('#search .results')
        .html(response)
        .slideDown(250)

  # Autocomplete search query by submitting the form.
  submitForm = ->
    $('#search form').trigger 'submit.rails'
  $('#search form input')
    .on 'keydown', _.debounce(submitForm, 350)
    .on 'blur', ->
      $('#search .results').hide()
      $('#search form input').val ''
