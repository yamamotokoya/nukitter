import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "overlay" ]

  connect() {
    this.startX = 0
    this.currentX = 0
    this.isOpen = false
    this.isSwiping = false // スワイプ中かどうかのフラグを追加

    this.boundTouchStart = this.touchStart.bind(this)
    this.boundTouchMove = this.touchMove.bind(this)
    this.boundTouchEnd = this.touchEnd.bind(this)

    document.addEventListener('touchstart', this.boundTouchStart, { passive: true })
    document.addEventListener('touchmove', this.boundTouchMove, { passive: false })
    document.addEventListener('touchend', this.boundTouchEnd, { passive: true })
  }

  disconnect() {
    document.removeEventListener('touchstart', this.boundTouchStart)
    document.removeEventListener('touchmove', this.boundTouchMove)
    document.removeEventListener('touchend', this.boundTouchEnd)
  }

  touchStart(e) {
    this.startX = e.touches[0].clientX
    this.isSwipeEdge = !this.isOpen && this.startX < 40
    this.isSwiping = false 
  }

  touchMove(e) {
    if (!this.isSwipeEdge && !this.isOpen) return
    
    this.currentX = e.touches[0].clientX
    let diff = this.currentX - this.startX

    // スワイプ方向の判定と、意図しない発火の防止
    if (this.isOpen && diff > 0) return 
    if (!this.isOpen && diff < 0) return

    this.isSwiping = true
    if (this.isOpen) {
      if (diff < 0) this.applyStyle(diff)
    } else {
      if (diff > 0 && diff <= 288) {
        this.overlayTarget.classList.remove("hidden")
        this.applyStyle(-288 + diff)
      }
    }
  }

  touchEnd() {
    if (!this.isSwiping) return // スワイプしていなければ何もしない（PCクリックを邪魔しない）

    let diff = this.currentX - this.startX
    
    // スタイルをリセットしてCSS制御に戻す
    this.contentTarget.style.transition = "transform 0.3s ease"
    this.contentTarget.style.transform = ""
    this.overlayTarget.style.opacity = ""

    if (this.isOpen) {
      if (diff < -80) this.close()
      else this.open()
    } else {
      if (this.isSwipeEdge && diff > 80) this.open()
      else if (this.isSwipeEdge) this.close()
    }
    
    setTimeout(() => {
      this.contentTarget.style.transition = ""
      this.isSwiping = false
    }, 300)
    this.isSwipeEdge = false
  }

  applyStyle(x) {
    this.contentTarget.style.transform = `translateX(${x}px)`
    this.contentTarget.style.transition = "none" 
    this.overlayTarget.style.opacity = Math.min(1, (x + 288) / 288)
  }

  toggle() {
    this.contentTarget.classList.contains("-translate-x-full") ? this.open() : this.close()
  }

  open() {
    this.isOpen = true
    this.overlayTarget.classList.remove("hidden")
    void this.contentTarget.offsetWidth 
    this.overlayTarget.classList.add("opacity-100")
    this.contentTarget.classList.remove("-translate-x-full")
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.isOpen = false
    this.contentTarget.classList.add("-translate-x-full")
    this.overlayTarget.classList.remove("opacity-100")
    setTimeout(() => {
      if (!this.isOpen) this.overlayTarget.classList.add("hidden")
      document.body.classList.remove("overflow-hidden")
    }, 300)
  }
}
