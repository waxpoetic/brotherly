import { Controller } from "stimulus"
import $ from "jquery"
import "slick-carousel"

export default class extends Controller {
  connect() {
    $(this.element).slick({
      slidesToShow: 4,
      swipeToSlide: true
    })
  }
}
