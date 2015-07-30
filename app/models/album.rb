class Album < ActiveRecord::Base
  belongs_to :site

  def player_iframe
    "<iframe style='border: 0; width: 100%; height: 120px;' src='https://bandcamp.com/EmbeddedPlayer/#{self.track_or_album}=#{self.bandcamp_id}/size=large/bgcol=ffffff/linkcol=0687f5/tracklist=false/artwork=small/transparent=true/' seamless><a href='#{self.url}'>#{self.title} by #{self.site.name}/a></iframe>".html_safe
  end

  def track_or_album
    if "com/track/".in? self.url
      "track"
    else
      "album"
    end
  end
  
end