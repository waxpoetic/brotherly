jQuery ->
  $('#admin #episodes .destroy a').on 'ajax:success', -> $(this).find('tr').fadeOut()
