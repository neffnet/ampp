class AddYoutubeToSites < ActiveRecord::Migration
  def change
    add_column :sites, :youtube, :string
  end
end
