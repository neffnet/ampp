class AddBandcampNameToSites < ActiveRecord::Migration
  def change
    add_column :sites, :bandcamp_name, :string
  end
end
