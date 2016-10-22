export function open(content) {
  $('#dialog').html(content);
  $('#dialog').fadeIn(250);
  $('#dialog-shadow').fadeIn(250);
}

export function close(content) {
  $('#dialog').fadeOut(250);
  $('#dialog-shadow').fadeOut(250);
}

export function load(content) {
  $('#dialog').trigger('dialog.open', content);
}

export default function(page) {
  page.find('#dialog')
    .on('dialog.open', dialog.open)
    .on('dialog.close', dialog.close);

  page.find('#dialog form')
    .on('ajax:success', dialog.load);

  page.find('#dialog .close')
    .on('click', dialog.close);
}
