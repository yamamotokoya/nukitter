class AddAffiliateUrlToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :affiliate_url, :string
  end
end
