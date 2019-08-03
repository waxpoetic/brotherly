import { Controller } from "stimulus"
import $ from "jquery"
import "slick-carousel"

export default class extends Controller {
  get options() {
    const slidesToShow = parseInt(this.data.get('slides') || 1)

    return { slidesToShow, swipeToSlide: true, autoplay: false }
  }

  connect() {
    $(this.element).slick(this.options)
  }
}
