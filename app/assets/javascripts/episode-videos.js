// Dispose all <video> elements before unloading the page.		
$(document).on('page:before-unload', function() {
  videojs('archive').dispose();
});

// Re-bind all <video> elements before changin the page
$(document).on('page:change', function() {
  videojs('archive');
});
