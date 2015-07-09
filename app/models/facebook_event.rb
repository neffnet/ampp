class FacebookEvent
  include Facebook
  attr_reader :id, :picture, :name, :venue, :address, :date, :time, :description, :link, :cover

  def initialize(facebook_event_id)
    @id = facebook_event_id

    FbGraph2.api_version = 'v2.3'
    event = FbGraph2::Event.new(@id, access_token: facebook_app_access_token).fetch(fields: 'name,description,place,cover')
    @description = event.description
    @name = event.name
    if event.raw_attributes['place']
      @venue = event.raw_attributes['place']['name']
      @address = get_address(event.raw_attributes['place'])
    else
      @venue = 'TBD'
      @address = 'TBD'
    end
    @date = get_date(event.start_time)
    @time = get_time(event.start_time)
    @link = 'https://facebook.com/' + event.id
    @cover = event.cover.source

    #get a picture
    get_pic = HTTParty.get( fb_graph + event.id + "/picture?access_token=#{facebook_app_access_token}&type=large&redirect=false" )
    @picture = get_pic['data']['url']
  end

  private

  def get_address(place)
    if place['location']
      "#{place['location']['street']} #{place['location']['city']}, #{place['location']['state']} #{place['location']['zip']}"
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