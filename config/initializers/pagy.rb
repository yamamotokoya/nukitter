# Pagyの基本設定
require 'pagy/extras/bootstrap' # スタイル用
require 'pagy/extras/overflow'  # ページ外アクセス対策

Pagy::DEFAULT[:items] = 20      # 1回に読み込む件数（まずは20件くらいがベスト）
Pagy::DEFAULT[:overflow] = :last_page # 存在しないページを指定されたら最後のページを出す
