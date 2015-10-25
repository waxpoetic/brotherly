closeButton = $('<a href="#" class="close">&times;</a>')
alertBox = (type, message) ->
  $('<div class="alert-box" data-alert />')
    .addClass(type)
    .html(message)
    .append(closeButton)
jQuery.fn.flash = (flashMessages) ->
  container = $(this).find '.large-12.columns'
  for type, message in flashMessages
    container.append alertBox(type, message)
