jQuery ->
  $('#new_message_form').on 'submit', ->
    form = $(this)
    author = form.find('input[name="message[author]"')
    body = form.find('input[name="message[body]"').val()
    App.chat.sendMessage(
      id: parseInt(Date.now()),
      type: 'message'
      author: author.val()
      body: body.val()
    )
    body.val('')
    return false
