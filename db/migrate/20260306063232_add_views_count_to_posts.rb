class AddViewsCountToPosts < ActiveRecord::Migration[8.0]
  def change
    # 第一引数: テーブル名 (:posts)
    # 第二引数: カラム名 (:views_count)
    # 第三引数: 型 (:integer)
    # 第四引数以降: オプション (default: 0, null: false)
    add_column :posts, :views_count, :integer, default: 0, null: false
  end
end
