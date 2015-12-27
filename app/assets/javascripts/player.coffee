$(document).ready ->
  $('.cloudcast-player').each (i, element) ->
    Mixcloud.PlayerWidget(element).ready.then (player) ->
      player.load $(element).attr('data-cloudcast-key')
