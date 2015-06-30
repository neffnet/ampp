class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :facebook_page_id
      t.references :user

      t.timestamps null: false
    end
  end
end
