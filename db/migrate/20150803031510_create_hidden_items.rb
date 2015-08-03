class CreateHiddenItems < ActiveRecord::Migration
  def change
    create_table :hidden_items do |t|
      t.integer :uuid
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
