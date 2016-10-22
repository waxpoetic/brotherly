export function loading(event) {
  $('#search .results').html(JST['searching']());
}
export function response(results) {
  $('#search .results').html(results);
}
export function submit(event) {
  $(event.currentTarget).closest('form').trigger('submit.rails');
}

export default function(page, autocomplete) {
  page.find('#search_form')
    .on('ajax:before', autocomplete.loading)
    .on('ajax:success', autocomplete.response);

  page.find('input[type="search"]')
      .on('keydown', _.debounce(autocomplete.submit, 350);
}
