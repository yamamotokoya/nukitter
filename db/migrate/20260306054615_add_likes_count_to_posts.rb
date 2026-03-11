class AddLikesCountToPosts < ActiveRecord::Migration[8.0]
  def change
    # 第一引数はテーブル名、第二引数はカラム名、第三引数は型、その後にオプションです
    add_column :posts, :likes_count, :integer, default: 0, null: false
  end
end
