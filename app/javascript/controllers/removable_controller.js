import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // 3秒後に要素を消去
    setTimeout(() => { this.remove() }, 3000)
  }

  remove() {
    this.element.remove()
  }
}
