// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = [ "content", "overlay" ]

//   connect() {
//     this.element.style.cursor = "pointer"
//   }

//   toggle() {
//     // メニューが隠れている（-translate-x-fullを持っている）なら開く、そうでなければ閉じる
//     if (this.contentTarget.classList.contains("-translate-x-full")) {
//       this.open()
//     } else {
//       this.close()
//     }
//   }

//   // open() {
//   //   // メニューを出す
//   //   this.contentTarget.classList.remove("-translate-x-full")
//   //   this.contentTarget.classList.add("translate-x-0")
    
//   //   // オーバーレイを出す
//   //   this.overlayTarget.classList.remove("hidden")
//   //   setTimeout(() => {
//   //     this.overlayTarget.classList.remove("opacity-0")
//   //   }, 10)

//   //   // 背面のスクロール禁止
//   //   document.body.classList.add("overflow-hidden")
//   // }

//   // open() メソッドの中身を以下のように調整
// open() {
//   this.overlayTarget.classList.remove("hidden")
  
//   // ブラウザに「描画（Reflow）」を強制させるための1行を追加
//   this.overlayTarget.offsetHeight 

//   this.contentTarget.classList.remove("-translate-x-full")
//   this.contentTarget.classList.add("translate-x-0")
//   this.overlayTarget.classList.add("opacity-100")
//   this.overlayTarget.classList.remove("opacity-0")
//   document.body.classList.add("overflow-hidden")
// }


//   close() {
//     // メニューを隠す
//     this.contentTarget.classList.add("-translate-x-full")
//     this.contentTarget.classList.remove("translate-x-0")
    
//     // オーバーレイを隠す
//     this.overlayTarget.classList.add("opacity-0")
//     setTimeout(() => {
//       this.overlayTarget.classList.add("hidden")
//     }, 300) // アニメーション時間に合わせて隠す

//     // 背面のスクロール許可
//     document.body.classList.remove("overflow-hidden")
//   }
// }
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "overlay" ]

  // iOS Safari でクリックイベントを確実に拾わせるための設定
  // connect() {
  //   this.element.style.cursor = "pointer"
  // }

  connect() {
  this.contentTarget.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', (e) => {
      // 1. 一旦、素の遷移を止める
      e.preventDefault()
      const href = link.getAttribute('href')

      // 2. 「スッ」と閉じるアニメーションを開始
      this.close()

      // 3. アニメーションの途中で、物理的にページを飛ばす（0.15秒後がベスト）
      setTimeout(() => {
        window.location.href = href
      }, 150) 
    })
  })
}
  // open(), close(), toggle() は今の「スッ」と動くロジックのまま！
  close() {
    this.contentTarget.classList.add("-translate-x-full")
    this.overlayTarget.classList.remove("opacity-100")
    setTimeout(() => {
      this.overlayTarget.classList.add("hidden")
      document.body.classList.remove("overflow-hidden")
    }, 300)
  }

  toggle(event) {
    if (event) event.preventDefault()
    this.contentTarget.classList.contains("-translate-x-full") ? this.open() : this.close()
  }

  open() {
    this.overlayTarget.classList.remove("hidden")
    // iOS でのアニメーション不発を防ぐための短い待機
    setTimeout(() => {
      this.overlayTarget.classList.add("opacity-100")
      this.contentTarget.classList.remove("-translate-x-full")
      document.body.classList.add("overflow-hidden")
    }, 20)
  }

  // close() {
  //   this.contentTarget.classList.add("-translate-x-full")
  //   this.overlayTarget.classList.remove("opacity-100")
  //   setTimeout(() => {
  //     this.overlayTarget.classList.add("hidden")
  //     document.body.classList.remove("overflow-hidden")
  //   }, 300)
  // }
}
