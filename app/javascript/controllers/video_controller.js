import { Controller } from "stimulus"
import videojs from "video.js"
import "@videojs/http-streaming"

/**
 * VideoJS Player
 */
export default class extends Controller {
  connect() {
    const id = this.element.getAttribute('id')
    const src = this.data.get('src')
    const type = 'application/x-mpegURL'

    videojs(id)
      .src({ src, type })
  }
}
