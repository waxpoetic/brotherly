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


jQuery ->
  flash = new FlashMessage()

  # Handle form response messages in a consistent way. Any flash
  # messages are populated into the headers of every response, used for
  # when Ajax requests are sending back response data to the front-end.
  # This JavaScript is responsible for populating the front-end with the
  # new flash messages, using our `FlashMessage` object.
  $('form')
    .on 'ajax:error', (xhr, status, error) ->
      flash.alert error
    .on 'ajax:complete', (event, xhr) ->
      flash.notice xhr.getResponseHeader('X-Flash-Notice')
      flash.alert xhr.getResponseHeader('X-Flash-Alert')
