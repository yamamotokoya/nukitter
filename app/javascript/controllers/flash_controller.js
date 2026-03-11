import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // 3秒（3000ミリ秒）後に消去アニメーションを開始
    setTimeout(() => {
      this.dismiss()
    }, 3000)
  }

  dismiss() {
    // ふわっと消えるアニメーション
    this.element.style.transition = "opacity 0.5s ease, transform 0.5s ease"
    this.element.style.opacity = "0"
    this.element.style.transform = "translate(-50%, -20px)"

    // アニメーションが終わったら要素を完全に削除
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}
