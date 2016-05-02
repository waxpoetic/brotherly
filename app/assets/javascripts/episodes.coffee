jQuery ->
  # Dispose all <video> elements before unloading the page.
  $(document).on 'page:before-unload', ->
    _.each $('.video-js'), (player) -> videojs(player.attr('id')).dispose()

  # Re-bind all <video> elements before unloading the page.
  $(document).on 'page:change', ->
    _.each $('.video-js'), (player) -> videojs(player.attr('id'))
