import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 1. container をターゲットに追加（これを忘れるとエラーになります）
  static targets = ["input", "preview", "container"]

  preview() {
    const file = this.inputTarget.files[0]
    if (file) {
      this.previewTarget.src = URL.createObjectURL(file)
      
      // 2. 親要素（container）を表示すれば、中の動画とボタンが同時に出ます
      this.containerTarget.classList.remove("hidden")
      this.previewTarget.load() // 動画を確実に読み込む
    }
  }

  reset() {
    this.inputTarget.value = ""
    this.previewTarget.src = ""
    
    // 3. 親要素（container）ごと隠せば、動画もボタンも一気に消えます
    this.containerTarget.classList.add("hidden")
  }
}
