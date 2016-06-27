jQuery ->
  # Dispose all <video> elements before unloading the page.
  $(document).on 'page:before-unload', ->
    $('.video-js').each (i, player) -> videojs(player.attr('id')).dispose()

  # Re-bind all <video> elements before unloading the page.
  $(document).on 'page:change', ->
    $('.video-js').each (player) -> videojs(player.attr('id'))
