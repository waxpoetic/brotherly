# Dispose all <video> elements before unloading the page.
$(document).on 'page:before-unload', ->
  videojs('archive').dispose()

# Re-bind all <video> elements before unloading the page.
$(document).on 'page:change', ->
  videojs('archive')
