import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "template"]

  disable() {
    // 1. ボタンを無効化（二重送信防止）
    this.buttonTarget.disabled = true
    
    // 2. ボタンの中身をテンプレート（スピナー + 送信中）に書き換える
    this.buttonTarget.innerHTML = this.templateTarget.innerHTML
    
    // 3. フォームを送信する（手動で submit を実行）
    this.element.closest("form").requestSubmit()
  }
}
