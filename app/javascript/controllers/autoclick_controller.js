import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.intersectObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          // 画面内に入ったら、Turbo FrameのURLをリロードさせる
          this.element.src = this.element.src
        }
      })
    })
    this.intersectObserver.observe(this.element)
  }

  disconnect() {
    this.intersectObserver.unobserve(this.element)
  }
}
