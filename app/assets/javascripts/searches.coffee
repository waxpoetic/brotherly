# Implements an autocomplete when users type 3 or more characters into
# the search bar by leveraging Rails remote forms and layout-free
# responses.
$(document).ready ->
  # Populate the results dropdown with new search term results, and show
  # an interstitial message while waiting for responses.
  $('#search_form')
    .on 'ajax:before', ->
      $('#search .results')
        .html('<li><label>Searching...</label></li>')
    .on 'ajax:success', (event, response) ->
      $('#search .results')
        .html(response)
        .slideDown(250)

  # Autocomplete form by submitting it with rails ujs
  submitForm = (event) ->
    $(event.currentTarget).closest('form').trigger 'submit.rails'

  # Bind autocomplete function to search form.
  $('#search_form input[type="search"]')
    .on 'keydown', _.debounce(submitForm, 350)
