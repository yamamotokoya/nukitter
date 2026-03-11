// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function() {
  // Twitterのスクリプトが読み込まれるのを待ってから実行
  const loadWidgets = () => {
    if (window.twttr && window.twttr.widgets) {
      window.twttr.widgets.load();
    }
  };
  
  loadWidgets();
  // Turboの描画とタイミングがズレる場合があるため、0.1秒後にもう一度試す
  setTimeout(loadWidgets, 100);
});
