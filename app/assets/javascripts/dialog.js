export function show() {
  $('.dialog-shadow').fadeIn(250).then(() ->
    $('#dialog').fadeIn(100)
  ).done();
}

export function hide() {
  $('.dialog-shadow').fadeOut(250).then(() ->
    $('#dialog').fadeOut(100)
  ).then(() ->
    $('#dialog').remove();
  ).done();
}

export function open(content, xhr) {
  let title = xhr.getReponseHeader('X-Title');

  $('body').append(
    JST['dialog']({
      title: title,
      content: content
    })
  );

  $('#dialog').trigger('dialog.open');
}

export function close() {
  $('#dialog').trigger('dialog.close');
}

export default function(page, dialog) {
  page.append(JST['dialog']());
  page
    .on('dialog.open', '#dialog', dialog.show)
    .on('dialog.close', '#dialog', dialog.hide);
    .on('ajax:success', 'a.dialog[data-remote]', dialog.open);
    .on('click', '#dialog .close', dialog.close);
}
