import { Controller } from "stimulus"
import videojs from "video.js"

/**
 * VideoJS Player
 */
export default class extends Controller {
  get id() {
    return this.element.getAttribute('id')
  }

  connect() {
    this.player = videojs(this.id)
    this.play()
  }

  play() {
    this.player.play()
  }

  disconnect() {
    this.player.dispose()
  }
}
