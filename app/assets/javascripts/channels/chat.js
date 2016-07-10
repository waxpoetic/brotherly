App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {
    let channel = this;

    $('#chat-output').append(
      JST['chat']({
        type: 'system',
        content: '* You have joined the chat.'
      })
    );

    $('#chat-input').on('submit', function(event) {
      let form = $(event.currentTarget),
          author = form.find('input[name="author"]'),
          content = form.find('input[name="content"]');

      channel.send({
        type: 'message',
        author: author.val(),
        content: content.val()
      });

      content.val('');
      return false;
    });
  },

  disconnected: function() {
    $('#chat-output').append(
      JST['chat']({
        type: 'system',
        content: '* You have been disconnected.'
      })
    );
  },

  received: function(data) {
    $('#chat-output').append(
      JST['chat'](data)
    );
  }
});
