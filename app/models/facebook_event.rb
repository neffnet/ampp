class FacebookEvent
  # require 'net/http'
  include Facebook
  attr_reader :id, :picture, :name, :venue, :address, :date, :time, :description, :link

  def initialize(facebook_event_id)
    @id = facebook_event_id

    FbGraph2.api_version = 'v2.3'
    event = FbGraph2::Event.new(@id, access_token: facebook_app_access_token, fields: ['cover', 'picture']).fetch
    @description = event.description
    @name = event.name
    @venue = event.owner.name
    @address = get_address(event.owner.id)
    @date = get_date(event.start_time)
    @time = get_time(event.start_time)
    @link = 'https://facebook.com/' + event.id

    #get picture source URL
    picture = HTTParty.get("https://graph.facebook.com/v2.3/#{@id}/picture?access_token=#{facebook_app_access_token}&type=large&redirect=false")
    @picture = picture['data']['url']
  end

  private

  def get_address(venue_id)
    address = HTTParty.get("https://graph.facebook.com/v2.3/#{venue_id}?access_token=#{facebook_app_access_token}&fields=location")
    if address['location']
      "#{address['location']['street']} #{address['location']['city']}, #{address['location']['state']} #{address['location']['zip']}"
    else
      @venue
    end
  end

  def get_date(timestring)
    timestring.strftime('%B %e, %Y')
  end

  def get_time(timestring)
    timestring.strftime('%l:%M %p')
  end
end