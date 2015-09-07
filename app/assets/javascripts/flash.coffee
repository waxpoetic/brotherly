# A class for manipulating the flash messages of a page.
class FlashMessage
  # Construct initial DOM elmeents.
  constructor: ->
    @flash = $('#flash')
    @notice = @_alertBox('notice')
    @alert = @_alertBox('alert')
    @closeButton = $('<a href="#" class="close" />').html('&times;')

  # Add a new notice message.
  notice: (message) ->
    return unless message?
    @notice.append @_paragraph(message)
    @notice.append @closeButton
    @flash.append @notice

  # Add a new alert message.
  alert: (message) ->
    return unless message?
    @alert.append @_paragraph(message)
    @alert.append @closeButton
    @flash.append @alert

  _paragraph: (msg) ->
    $('<p />').text(msg)

  _alertBox: (type) ->
    $('<div />')
      .addClass("alert-box #{@_kindOf(type)}")
      .attr('data-alert', true)

  _kindOf: (type) ->
    if type == 'notice' then 'success' else type

# "export" the flash object.
@flash = new FlashMessage()
