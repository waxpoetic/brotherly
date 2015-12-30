import $ from 'jquery';

// Show an interstitial message while waiting for responses.
let showSearchingMessage = function() {
  $('#search .results')
    .html('<li><label>Searching...</label></li>')
    .slideDown(250);
};

// Populate the results dropdown with new search term results.
let populateSearchResults = function() {
  $('#search .results').html(response).slideDown(250);
};

// Submit the search form with jQuery UJS
let submitSearchForm = function(event) {
  $(event.currentTarget).closest('form').trigger('submit.rails');
};

export default function() {
  $('#search form')
    .on('ajax:before', showSearchingMessage)
    .on('ajax:success', populateSearchResults)
    .find('input[type="search"]')
      .on('keydown', _.debounce(submitSearchForm, 350));
}
