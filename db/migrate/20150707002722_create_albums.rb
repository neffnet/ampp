class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :bandcamp_id
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
