import $ from 'jquery';

// Load any form responses back into the #dialog HTML
export default function() {
  $('#dialog form')
    .on('ajax:success', (event, response) => $('#dialog').html(response));
}
