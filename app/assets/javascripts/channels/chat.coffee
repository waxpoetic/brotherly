App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    @perform 'send_message',
      message: "#{@_author()} has entered the room."
      type: 'notice'

  disconnected: ->
    @perform 'send_message',
      message: "#{@_author()} has left the room."
      type: 'notice'

  received: (data) ->
    @_append JST["chat/#{data.type}"](data)

  sendMessage: (data) ->
    @perform 'send_message', data

  _append: (html) ->
    $('#messages').append html

  _author: ->
    $('#new_message_form input[name="message[author]"]').val() || 'User'
