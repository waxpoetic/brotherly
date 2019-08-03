import { Controller } from "stimulus"
import videojs from "video.js"

/**
 * VideoJS Player
 */
export default class extends Controller {
  connect() {
    this.player = videojs(this.element.getAttribute('id'))
    this.player.play()
  }

  disconnect() {
    this.player.dispose()
  }
}
