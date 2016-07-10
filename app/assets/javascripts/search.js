export function autocomplete(event) {
  let input = $(event.currentTarget);

  if (input.val().length >= 3) {
    input.closest('form').trigger('submit.rails');
  }
}

export function results(content) {
  $('#search .results').html(content).slideDown(250);
}

export function loading() {
  $('#search .results').html(JST['searching']());
}

export default function(page, search) {
  page.find('#search form')
    .on('ajax:before', search.loading)
    .on('ajax:success', search.results)

  page.find('#search input[type="search"]')
    .on('keydown', _.debounce(search.autocomplete, 350))
}
