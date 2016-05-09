App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    @_append JST['chat/notice'](message: 'Connected')

  disconnected: ->
    @_append JST['chat/notice'](message: 'Disconnected')

  received: (data) ->
    @_append JST["chat/#{data.type}"](data)

  _append: (html) ->
    $('#messages').append html
