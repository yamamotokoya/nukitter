class AddStreamerToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :streamer, foreign_key: true
  end
end
