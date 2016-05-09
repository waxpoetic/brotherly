jQuery ->
  $('#new_message_form').on 'submit', ->
    form = $(this)
    App.chat.sendMessage(
      id: parseInt(Date.now()),
      type: 'message'
      author: form.find('input[name="message[author]"').val()
      body: form.find('input[name="message[body]"').val()
    )
