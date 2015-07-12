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
    events_data1 = HTTParty.get( "https://graph.facebook.com/v2.3/" + @site.facebook_page_id + "/events", query: events_query ).first[1]
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

    photo_albums_data1 = HTTParty.get( fb_graph + @site.facebook_page_id + "/albums?access_token=#{facebook_app_access_token}&fields=id,name,picture,created_time" ).first[1]
    photo_albums_data = photo_albums_data1.sort_by{|a| a['created_time']}.reverse
    @photo_albums = photo_albums_data.map do |a|
      {
        :id => a['id'],
        :name => a['name'],
        :thumbnail => a['picture']['data']['url']
      }
    end
  end

  protected

  def site_params
    params.require(:site).permit(:name, :facebook_page_id, :bandcamp_name)
  end

end
