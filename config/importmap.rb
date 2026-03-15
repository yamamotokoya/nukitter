# Pin npm packages by running ./bin/importmap

# pin "application"
# pin "@hotwired/turbo-rails", to: "turbo.min.js"
# pin "@hotwired/stimulus", to: "stimulus.min.js"
# pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
# # pin_all_from "app/javascript/controllers", under: "controllers"
# # config/importmap.rb

# # 404の原因になっているこの行をコメントアウト（または削除）
# # pin_all_from "app/javascript/controllers", under: "controllers"

# # 代わりに、1つずつ「.js」を含めて明示的にピン留めする
# pin "controllers/application", to: "controllers/application.js"
# pin "controllers/menu_controller", to: "controllers/menu_controller.js"
# pin "controllers/toggle_controller", to: "controllers/toggle_controller.js"
# pin "controllers/removable_controller", to: "controllers/removable_controller.js"
# pin "controllers/submit_controller", to: "controllers/submit_controller.js"
# pin "controllers/video_preview_controller", to: "controllers/video_preview_controller.js"

# 他に 404 が出ているコントローラーがあればここに追加

# config/importmap.rb
# pin "application"
# pin "@hotwired/turbo-rails", to: "turbo.min.js"
# pin "@hotwired/stimulus", to: "stimulus.min.js"
# pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# # 各コントローラーを明示的にピン留め（404対策で .js を含める）
# pin "controllers/application", to: "controllers/application.js"
# pin "controllers/hello_controller", to: "controllers/hello_controller.js"
# pin "controllers/menu_controller", to: "controllers/menu_controller.js"
# pin "controllers/toggle_controller", to: "controllers/toggle_controller.js"
# pin "controllers/removable_controller", to: "controllers/removable_controller.js"
# pin "controllers/submit_controller", to: "controllers/submit_controller.js"
# pin "controllers/video_preview_controller", to: "controllers/video_preview_controller.js"

# config/importmap.rb
# pin "application"
# pin "@hotwired/turbo-rails", to: "turbo.min.js"
# pin "@hotwired/stimulus", to: "stimulus.min.js"
# pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# # 各コントローラーを「拡張子あり」で明示的に定義
# pin "controllers/application", to: "controllers/application.js"
# pin "controllers/hello_controller", to: "controllers/hello_controller.js"
# pin "controllers/menu_controller", to: "controllers/menu_controller.js"
# pin "controllers/removable_controller", to: "controllers/removable_controller.js"
# pin "controllers/submit_controller", to: "controllers/submit_controller.js"
# pin "controllers/toggle_controller", to: "controllers/toggle_controller.js"
# pin "application"
# pin "@hotwired/turbo-rails", to: "turbo.min.js"
# pin "@hotwired/stimulus", to: "stimulus.min.js"
# pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# # フォルダ全体をピン留めする。これが一番404になりにくい公式の書き方です
# pin_all_from "app/javascript/controllers", under: "controllers"
# config/importmap.rb
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
