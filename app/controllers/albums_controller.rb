class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @site = Site.find(params[:site_id])
    @album = @site.albums.build(album_params)

    if user_signed_in? && @album.site.user == current_user
      if @album.save
        flash[:notice] = "Streaming bandcamp album added!"
        redirect_to edit_site_path @site
      else
        flash[:error] = "Something went wrong: #{@album.errors}"
        redirect_to edit_site_path @site
      end
    else
      flash[:error] = "You must be signed in to do this"
      redirect_to edit_site_path @site
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if user_signed_in? && @album.site.user == current_user 
      if @album.destroy
        flash[:notice] = "Album deleted successfully"
        redirect_to edit_site_path @album.site
      else
        flash[:error] = "There was a problem, please try again"
        redirect_to edit_site_path @album.site
      end
    else
      flash[:error] = "Error: You must be signed in and own the album"
      redirect_to edit_site_path @album.site
    end
  end

  protected

  def album_params
    params.require(:album).permit(:url, :bandcamp_id)
  end
end
