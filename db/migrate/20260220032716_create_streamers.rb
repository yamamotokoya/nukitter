class CreateStreamers < ActiveRecord::Migration[8.1]
  def change
    create_table :streamers do |t|
      t.string :name
      t.string :x_url

      t.timestamps
    end
  end
end
