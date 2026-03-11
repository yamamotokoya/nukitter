import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ["placeholder"]

  replace() {
    // 1. プレースホルダー（ボタン）を消す
    if (this.hasPlaceholderTarget) {
      this.placeholderTarget.classList.add("hidden")
    }

    // 2. Xの埋め込みHTMLを生成して挿入
    this.element.innerHTML = `
      <div class="w-full flex justify-center">
        <blockquote class="twitter-video" data-media-max-width="560">
          <a href="${this.urlValue}"></a>
        </blockquote>
      </div>
    `

    // 3. Xのスクリプトを走らせてプレイヤーに変換
    if (window.twttr && window.twttr.widgets) {
      window.twttr.widgets.load(this.element)
    } else {
      // スクリプト未読み込みの場合のフォールバック
      const script = document.createElement('script')
      script.src = "https://platform.twitter.com"
      document.head.appendChild(script)
    }
  }
}
