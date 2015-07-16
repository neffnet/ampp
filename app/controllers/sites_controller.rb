class SitesController < ApplicationController
  include Facebook

  def new
    @site = Site.new
  end

  def create
    @site = current_user.sites.build(site_params)

    if @site.save
      flash[:notice] = "#{@site.name} site created!" 
      redirect_to @site
    else
      flash[:error] = @site.errors
      render :new
    end
  end

  def destroy
    @site = Site.find(params[:id])
    if @site.destroy
      flash[:notice] = "The site has been deleted"
      redirect_to root_path
    else
      flash[:error] = "Oops, something went wrong and nothing happened"
      redirect_to root_path
    end
  end

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(site_params)
      flash[:notice] = "#{@site.name} site updated successfully"
      redirect_to @site
    else
      flash[:error] = "Something went wrong. Please try again."
      render :edit
    end
  end

  def show
    @site = Site.find(params[:id])

    events_query = { access_token: facebook_app_access_token, fields: 'name,id,place,description,cover,picture' }
    url = URI.escape("https://graph.facebook.com/v2.3/" + @site.facebook_page_id + "/events")
    events_data1 = HTTParty.get( url, query: events_query ).first[1]
    events_data = events_data1.find_all{|e| Time.parse(e['start_time']) >= Time.now}.sort_by{|e| e['start_time']} 
    events = events_data.map do |e|
      {
        :id => e['id'],
        :name => e['name'],
        :time => Time.parse(e['start_time']).strftime('%l:%M %p'),
        :date => Time.parse(e['start_time']).strftime('%B %e, %Y'),
        :picture => e['picture']['data']['url'],
        :cover => e['cover']['source'],
        :description => e['description'],
        :link => "http://facebook.com/#{e['id']}",
        :venue => e['place']['name'],
        :address => e['place']['location']['street'].to_s + ' ' + e['place']['location']['city'].to_s + ', ' + e['place']['location']['state'].to_s + ' ' + e['place']['location']['zip'].split.first.to_s
      } unless !(e.has_key? 'place')
    end
    @events = events.compact

    url = URI.escape( fb_graph + @site.facebook_page_id + "/albums?access_token=#{facebook_app_access_token}&fields=id,name,picture,created_time" )
    photo_albums_data1 = HTTParty.get(url).first[1]
    photo_albums_data = photo_albums_data1.sort_by{|a| a['created_time']}.reverse
    @photo_albums = photo_albums_data.map do |a|
      {
        :id => a['id'],
        :name => a['name'],
        :thumbnail => a['picture']['data']['url']
      }
    end    
  end

  def get_album
    id = params[:id]
    url = URI.escape(fb_graph + id + "/photos?fields=images,height,width,name&access_token=#{facebook_app_access_token}&pretty=1&limit=25")
    data = HTTParty.get( url, format: :json)
    
    @photos = data['data'].map do |photo|
      sorted = photo['images'].sort{|img| img['height']}
      {
        :thumb => sorted.first['source'],
        :full => sorted.last['source'],
        :name => photo['name'],
        :height => sorted.last['height'],
        :width => sorted.last['width']
      }
    end

    while data['paging']['next'] do
      url = URI.escape(fb_graph + id + "/photos?fields=images,height,width,name&access_token=#{facebook_app_access_token}&pretty=1&limit=25&after=#{data['paging']['cursors']['after']}")
      data = HTTParty.get( url, format: :json )
      data['data'].each do |photo|
        sorted = photo['images'].sort{|img| img['height']}
        next_image = {
          :thumb => sorted.first['source'],
          :full => sorted.last['source'],
          :name => photo['name'],
          :height => sorted.last['height'],
          :width => sorted.last['width']
        }
        @photos << next_image
      end
    end

    render json: @photos
  end

  protected

  def site_params
    params.require(:site).permit(:name, :facebook_page_id, :bandcamp_name)
  end

end
