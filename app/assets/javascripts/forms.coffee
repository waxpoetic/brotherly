# Generic responses to ajax forms
$(document)
  .on 'ajax:error', (event, status, error) ->
    flash.alert error
  .on 'ajax:complete', (event, xhr) ->
    flash.notice xhr.getResponseHeader('X-Flash-Notice')
    flash.alert xhr.getResponseHeader('X-Flash-Alert')
