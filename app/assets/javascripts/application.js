//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require refile
//= require lodash
//= require video
//= require turbolinks
//= require_self


function withVideoPlayer(slick, current, callback) {
  var slide = $(slick.$slides[current]),
      element = slide.find('.video-player');

  if (element.length) {
    var player = videojs(element.attr('id'));
    callback(player)
  }
}

$(document)
  .on('turbolinks:load', function(event) {
    // Load static VideoJS player elements
    $('.video__player .video-player').each(function(i, element) {
      var player = videojs($(element).attr('id'));
      player.play();
    });

    // Configure slick-slider for .filmstrip components
    $('.filmstrip').slick({
      slidesToShow: 4,
      swipeToSlide: true
    });

    // Configure slick-slider for the home page slideshow
    $('.home-page__slideshow')
      .on('afterChange', function(event, slick, currentSlide) {
        withVideoPlayer(slick, currentSlide, function(player) {
          slick.pause();
          player.play();
        });
      })
      .on('beforeChange', function(event, slick, currentSlide) {
        withVideoPlayer(slick, currentSlide, function(player) {
          player.pause();
          player.dispose();
        });

        slick.play();
      })
      .slick({
        slidesToShow: 1,
        swipeToSlide: true,
        autoplay: false
      });

  })
  .on('turbolinks:before-visit', function() {
    // Dispose VideoJS elements before unloading the page
    $('.video-player').each(function(i, element) {
      videojs($(element).attr('id')).dispose();
    });
  })
