class AddXVideoUrlToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :x_video_url, :string
  end
end
