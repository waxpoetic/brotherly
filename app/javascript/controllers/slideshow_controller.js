import { Controller } from "stimulus"
import $ from "jquery"
import "slick-carousel"

export default class extends Controller {
  withVideoPlayer(slick, current, callback) {
    const slide = $(slick.$slides[current]),
          element = slide.find('.video-player')

    if (element.length) {
      const player = videojs(element.attr('id'))
      callback(player);
    }
  }

  play(event, slick, currentSlide) {
    this.withVideoPlayer(slick, currentSlide, (player) => {
      slick.pause()
      player.play()
    })
  }

  pause(event, slick, currentSlide) {
    this.withVideoPlayer(slick, currentSlide, (player) => {
      player.pause()
      player.dispose()
    });
  }

  connect() {
    $(this.element)
      .slick({
        slidesToShow: 1,
        swipeToSlide: true,
        autoplay: false
      })
      .on('beforeChange', this.pause)
      .on('afterChange', this.play)
  }
}
