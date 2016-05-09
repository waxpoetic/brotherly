jQuery ->
  # Clear out the form on a new submission
  $('#new_message_form').on 'ajax:success', ->
    $(this).find('input[name="body"]').val ''
