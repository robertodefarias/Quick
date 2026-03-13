class AddImageUrlToTrips < ActiveRecord::Migration[8.1]
  def change
    add_column :trips, :image_url, :string
    add_column :trips, :string, :string
  end
end
