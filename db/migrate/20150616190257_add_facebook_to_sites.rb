class AddFacebookToSites < ActiveRecord::Migration
  def change
    add_column :sites, :fb_page_id, :integer
  end
end
