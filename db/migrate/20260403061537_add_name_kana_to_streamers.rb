class AddNameKanaToStreamers < ActiveRecord::Migration[8.1]
  def change
    add_column :streamers, :name_kana, :string
  end
end
