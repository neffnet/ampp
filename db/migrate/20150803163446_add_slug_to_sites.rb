class AddSlugToSites < ActiveRecord::Migration
  def change
    add_column :sites, :slug, :string
    add_index :sites, :slug
  end
end
