export function close(event) {
  let message = $(event.currentTarget).closest('.message');
  message.fadeOut(100).then(message.remove);
}

export function render(xhr) {
  let messages = JSON.parse(xhr.getResponseHeader('X-Flash'));

  for (let type in messages) {
    $('#flash').append(
      JST['flash']({ type: type, message: messages[type] })
    );
  }
}

export default function(page, flash) {
  page.find('#flash .message .close', flash.close);
  page.on('ajax:complete', flash.render);
}
