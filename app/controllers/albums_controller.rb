class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @site = Site.find(params[:site_id])
    @album = site.albums.build(album_params)

    if @album.save
      flash[:notice] = "Streaming bandcamp album added!"
      redirect_to edit_site_path @site
    else
      flash[:error] = "Something went wrong: #{@album.errors}"
      redirect_to edit_site_path @site
    end
  end

  def destroy
  end
end
