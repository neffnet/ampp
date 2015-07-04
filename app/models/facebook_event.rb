class FacebookEvent
  # require 'net/http'
  include Facebook
  attr_reader :id, :picture, :name, :venue, :address, :date, :time, :description

  def initialize(facebook_event_id)
    @id = facebook_event_id

    FbGraph2.api_version = 'v2.3'
    event = FbGraph2::Event.new(@id, access_token: facebook_app_access_token, fields: ['cover', 'picture']).fetch
    @description = event.description
    @name = event.name
    @venue = event.owner.name
    @address = address(event.owner.id)
    @date = date(event.start_time)
    @time = time(event.start_time)

    #get picture source URL
    # first try - undefined method split for access_token:symbol

    # url = URI.parse("https://graph.facebook.com/v2.3/#{@id}/picture")
    # params = {access_token: facebook_app_access_token, type: 'large'}
    # http = Net::HTTP.new('graph.facebook.com', url.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    # @picture = http.get(url, params)

    # try it with httparty gem
    response = HTTParty.get("https://graph.facebook.com/v2.3/#{@id}/picture?access_token=#{facebook_app_access_token}&type=large")
    @picture = response.headers.location
  end

  def address(venue_id)

  end

  def date(timestring)

  end

  def time(timestring)

  end
end