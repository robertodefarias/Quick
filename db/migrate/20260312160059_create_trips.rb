class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.string :city
      t.text :content

      t.timestamps
    end
  end
end
