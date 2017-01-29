//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require refile
//= require lodash
//= require video
//= require turbolinks
//= require_self

$(document)
  .on('turbolinks:load', function(event) {
    // Load VideoJS player into #archive element if it exists
    if ($('#player').length) {
      videojs('player');
    }

    // Configure slick-slider for .filmstrip components
    $('.filmstrip').slick({
      slidesToShow: 4,
      swipeToSlide: true
    });
  })
  .on('turbolinks:before-visit', function() {
    // Dispose VideoJS elements before unloading the page
    if ($('#player').length) {
      videojs('player').dispose();
    }
  })
