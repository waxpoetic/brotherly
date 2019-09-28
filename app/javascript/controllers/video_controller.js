import { Controller } from "stimulus"
import videojs from "video.js"
import "@videojs/http-streaming"

/**
 * VideoJS Player
 */
export default class extends Controller {
  connect() {
    const src = this.data.get('src')
    const type = 'application/x-mpegURL'

    videojs(this.element).src({ src, type })
  }
}
