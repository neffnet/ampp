class ChangeFbIntToString < ActiveRecord::Migration
  def change
    change_column :sites, :fb_page_id, :string
  end
end
