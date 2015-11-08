jQuery ->
  $(document).on 'opened.fndtn.reveal', '#admin [data-reveal]', ->
    $('input.date_picker').fdatetimepicker
      format: 'yyyy-mm-dd hh:ii',
      startDate: new Date()

  $(document)
    .on 'page:fetch', ->
      $('main').addClass 'disabled'
      $('main input, main textarea').attr 'disabled', true
    .on 'page:load', ->
      $('main').removeClass 'disabled'
  $('#admin a, #admin form')
    .on 'ajax:error', (event, status, error) ->
      $('#flash').flash alert: error
    .on 'ajax:complete', (event, xhr) ->
      $('#title h1').text xhr.getResponseHeader('X-Title')
      $('title').text xhr.getResponseHeader('X-Page-Title')
      $('#flash').flash
        notice: xhr.getResponseHeader('X-Flash-Notice')
        alert: xhr.getResponseHeader('X-Flash-Alert')

  $('#admin form')
    .on 'ajax:success', (event, response) ->
      $('#admin main').html response

  $('#admin #dialog form')
    .on 'ajax:success', ->
      $('#dialog').foundation 'reveal', 'close'

  $('#admin .destroy.button')
    .on 'ajax:success', ->
      $(this).closest('tr').fadeOut()


