import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "overlay" ]

  connect() {
    this.startX = 0
    this.currentX = 0
    this.isOpen = false

    // 指が触れた瞬間のイベント登録
    document.addEventListener('touchstart', this.touchStart.bind(this), { passive: true })
    document.addEventListener('touchmove', this.touchMove.bind(this), { passive: false })
    document.addEventListener('touchend', this.touchEnd.bind(this), { passive: true })
  }

  // --- フリック操作のロジック ---
  touchStart(e) {
    this.startX = e.touches[0].clientX
    // 画面の左端（30px以内）からスワイプ開始した時だけ反応させる
    this.isSwipeEdge = this.startX < 30 
  }

  touchMove(e) {
    if (!this.isSwipeEdge && !this.isOpen) return
    
    this.currentX = e.touches[0].clientX
    let diff = this.currentX - this.startX

    if (this.isOpen) {
      // メニューが開いている時に左へスワイプして閉じる
      if (diff < 0) {
        this.contentTarget.style.transform = `translateX(${diff}px)`
        this.overlayTarget.style.opacity = Math.max(0, 1 + diff / 300)
      }
    } else {
      // 画面左端から右へスワイプして出す
      if (diff > 0 && diff <= 288) {
        this.contentTarget.style.transform = `translateX(${-288 + diff}px)`
        this.overlayTarget.classList.remove("hidden")
        this.overlayTarget.style.opacity = diff / 300
      }
    }
  }

  touchEnd() {
    let diff = this.currentX - this.startX
    if (this.isOpen) {
      if (diff < -100) this.close() // 100px以上左へ引いたら閉じる
      else this.open() // 戻す
    } else {
      if (diff > 100) this.open() // 100px以上右へ引いたら開く
      else this.close() // 戻す
    }
    // インラインスタイルをクリアしてCSSのクラス制御に戻す
    this.contentTarget.style.transform = ""
    this.overlayTarget.style.opacity = ""
  }

  // --- 従来のクリック操作 ---
  toggle() {
    this.contentTarget.classList.contains("-translate-x-full") ? this.open() : this.close()
  }

  open() {
    this.isOpen = true
    this.overlayTarget.classList.remove("hidden")
    setTimeout(() => {
      this.overlayTarget.classList.add("opacity-100")
      this.contentTarget.classList.remove("-translate-x-full")
      document.body.classList.add("overflow-hidden")
    }, 10)
  }

  close() {
    this.isOpen = false
    this.contentTarget.classList.add("-translate-x-full")
    this.overlayTarget.classList.remove("opacity-100")
    setTimeout(() => {
      this.overlayTarget.classList.add("hidden")
      document.body.classList.remove("overflow-hidden")
    }, 300)
  }
}
