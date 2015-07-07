module SitesHelper
  
  def streaming_player(album)
    "<iframe style='border: 0; width: 100%; height: 120px;' src='https://bandcamp.com/EmbeddedPlayer/album=#{album.bandcamp_id}/size=large/bgcol=ffffff/linkcol=0687f5/tracklist=false/artwork=small/transparent=true/' seamless><a href='#{album.url}'>You Knew by Mother Falcon</a></iframe>".html_safe
  end

end
