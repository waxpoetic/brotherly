//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require refile
//= require lodash
//= require video
//= require fullpage
//= require turbolinks
//= require_self

$(document)
  .on('turbolinks:load', function() {
    // Load VideoJS player into #archive element if it exists
    if ($('#player').length) {
      videojs('player');
    }

    // Configure slick-slider for .filmstrip components
    $('.filmstrip').slick({
      slidesToShow: 4,
      swipeToSlide: true
    });

    $('.home-page__slideshow').slick({
      slidesToShow: 1,
      swipeToSlide: true
    });

    // // Configure fullPage.js
    // $('.home-page__slideshow').fullpage({
    //   verticalCentered: true
    // });
  })
  .on('turbolinks:before-visit', function() {
    // Dispose VideoJS elements before unloading the page
    if ($('#player').length) {
      videojs('player').dispose();
    }
  })
