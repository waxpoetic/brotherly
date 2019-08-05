import { Controller } from "stimulus"
import Siema from "siema"

export default class extends Controller {
  connect() {
    const selector = '.slideshow__slides'
    const perPage = parseInt(this.data.get('slides') || 1)
    const loop = true

    this.siema = new Siema({ selector, perPage, loop })
  }

  previous(event) {
    event.preventDefault()
    this.siema.prev()
  }

  next(event) {
    event.preventDefault()
    this.siema.next()
  }
}
